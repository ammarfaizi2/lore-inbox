Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315233AbSEFW0l>; Mon, 6 May 2002 18:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315237AbSEFW0j>; Mon, 6 May 2002 18:26:39 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:8389 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S315233AbSEFWZy>; Mon, 6 May 2002 18:25:54 -0400
Date: Tue, 7 May 2002 00:21:25 +0200
From: Erich Schubert <erich@debian.org>
To: linux-kernel@vger.kernel.org
Subject: diff NOT needed. Re: Problems with VIA Apollo Pro Chipsets
Message-ID: <20020506222125.GA2005@marvin.xmldesign.de>
In-Reply-To: <20020505112645.GA20633@marvin.xmldesign.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
X-GPG: 4B3A135C 6073 C874 8488 BCDA A6A9  B761 9ED0 78EF 4B3A 135C
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After removing one memory chip that was broken (at least memtest86 found
errors) i got rid of all errors, it seems.
So this diff is NOT needed...

The diff seemed to improve things, but i guess that was just luck...
Sorry for being too fast on that issue.

My current kernel, 2.4.19-pre7-jp10, reports the bridge now as
00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
(rev 40)

So it probably isn't the known-to-be-broken one...

> --- /usr/src/linux/drivers/pci/quirks.c	Mon Feb 25 20:38:03 2002
> +++ /home/erich/coding/v2.4.18/drivers/pci/quirks.c	Sun May  5 12:38:07 2002
> @@ -487,6 +487,7 @@
>  	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency },
>  	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8371_1,	quirk_vialatency },
>  	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	0x3112	/* Not out yet ? */,	quirk_vialatency },
> +	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C598_1,	quirk_vialatency },
>  	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C576,	quirk_vsfx },
>  	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_viaetbf },
>  	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_82C597_0,	quirk_vt82c598_id },

Gruss,
Erich Schubert

--
erich@(mucl.de|debian.org)        --        GPG Key ID: 4B3A135C
A polar bear is a rectangular bear after a coordinate transform.
Die kürzeste Verbindung zwischen zwei Menschen ist ein Lächeln.
