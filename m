Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750836AbWCROYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWCROYJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Mar 2006 09:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751536AbWCROYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Mar 2006 09:24:09 -0500
Received: from main.gmane.org ([80.91.229.2]:62613 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750836AbWCROYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Mar 2006 09:24:07 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Sat, 18 Mar 2006 14:23:53 +0000
Message-ID: <yw1x64mb7rwm.fsf@agrajag.inprovide.com>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org> <20060317144920.GS20746@lug-owl.de> <dveugj$aob$1@sea.gmane.org> <yw1xmzfo98em.fsf@agrajag.inprovide.com> <dvh3rb$ui8$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (linux)
Cancel-Lock: sha1:w8K2pAWFDdyHghjPWDD+4k4rTl0=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andras Mantia <amantia@kde.org> writes:

> Måns Rullgård wrote:
>
>> I didn't do anything else.  Check that your chipset has the same PCI
>> ID that the patch is for.
>> 
>
> Indeed, the problem is here. If I use 
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,     PCI_ANY_ID,    
> asus_hides_ac97_lpc );
>
> (see the PCI_ANY_ID) instead of 
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_VIA,   PCI_DEVICE_ID_VIA_8237,
> asus_hides_ac97_lpc );
>
> (and remove the check "if (likely(!asus_hides_ac97)) return;")
> it works. I cannot see the output about enabling the device in "dmesg | grep
> PCI", but lspci shows the audio and modem device.
> And it works both with the 2.6.13 suse and 2.6.15 vanilla kernel.

That certainly suggests that your chipset has a different PCI ID.

> I managed to hang the machine completely with skype, altough before that a
> quick test showed that the device works, as I could hear the music. Maybe
> it's the same problem you've experienced.

With the card in the bad slot I only got a few seconds of sound before
the machine locked up.  Since you have a different board, it could of
course still be a similar problem, just less likely to happen.

Which sound card were you using when your machine hung?

> Can you tell me how can I find the real device ID for my chipset? It
> *should* be the same one as the original writer of the patch wrote (he also
> had an ASUS A8V Deluxe as I understood), but the experience tells it is
> not.

lspci -n will list the PCI IDs in hex.

-- 
Måns Rullgård
mru@inprovide.com

