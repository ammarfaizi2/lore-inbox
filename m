Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934373AbWKUO5h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934373AbWKUO5h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 09:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934375AbWKUO5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 09:57:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:27870 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S934373AbWKUO5g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 09:57:36 -0500
X-Authenticated: #31060655
Message-ID: <45631455.9000805@gmx.net>
Date: Tue, 21 Nov 2006 15:59:33 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2006@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060911 SUSE/1.0.5-1.1 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Alan <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: first proposal for pci resume quirk interface
References: <20061114175510.6e7c7119@localhost.localdomain>
In-Reply-To: <20061114175510.6e7c7119@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan wrote:
> --- linux.vanilla-2.6.19-rc5-mm1/arch/i386/pci/fixup.c	2006-11-10 10:38:25.000000000 +0000
> +++ linux-2.6.19-rc5-mm1/arch/i386/pci/fixup.c	2006-11-14 15:13:03.000000000 +0000
> @@ -117,7 +117,7 @@
>  #define VIA_8363_KL133_REVISION_ID 0x81
>  #define VIA_8363_KM133_REVISION_ID 0x84
>  
> -static void __devinit pci_fixup_via_northbridge_bug(struct pci_dev *d)
> +static void pci_fixup_via_northbridge_bug(struct pci_dev *d)
>  {
>  	u8 v;
>  	u8 revision;

I sent a similar patch about one year ago and it was rejected back then.
Any reasons why fixups on resume suddenly are desirable?
(I agree with the patch wholehartedly and will test it ASAP on my
Samsung P35 laptop which needs the asus_hides_smbus quirk.)

Regards,
Carl-Daniel
