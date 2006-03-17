Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030266AbWCQTQD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWCQTQD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 14:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbWCQTQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 14:16:01 -0500
Received: from main.gmane.org ([80.91.229.2]:26806 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030266AbWCQTQB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 14:16:01 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Fri, 17 Mar 2006 19:15:37 +0000
Message-ID: <yw1xr750992e.fsf@agrajag.inprovide.com>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (linux)
Cancel-Lock: sha1:VeCAspa1OQG4bdBC7Ia2hk5n+4g=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andras Mantia <amantia@kde.org> writes:

> Jan-Benedict Glaw wrote:
>
>> Just for the records, it happens actually quite often that some little
>> features / improvements of a chipset have bugs; from time to time,
>> you'll see a BIOS update that doesn't really do more than switching
>> off that feature. I guess that quite some of our quirks originate from
>> looking at what a newer BIOS configures differently compared to an
>> older version.  Some instability can be fixed that way (though it's
>> better to have a fix for such a bug inside the BIOS: this way, the fix
>> is in place at the time the Linux kernel is loaded, so there's no way
>> for it to eg. cause memory corruption between loading the kernel and
>> issueing the quirks.)
> I know, but in this case I got this answer: 
> " Dear Friend :
>   Thank you for contacting ASUS Customer Service.
>   My name is ZYC, and I would be assisting you today. 
>  sorry ,due to chipset limitation ,
> when you add a PCI AUDIO card to a board which use VIA VT8237 southbridge
> controller ,
> the built in AC97 audio will be disabled automaticly .
> it is a chip limitation without way to fix ."

What a liar.

> Meantime I tried the patch against the 2.6.13-15 kernel shipped with SuSE 10
> (applied without errors), and altough I see 
> PCI: enabled onboard AC97/MC97 devices
>
> in the logs, the onboard  card doesn't appear in lspci.
>
> I'm downloading the 2.6.16-rc6 kernel to try with that one. Mine is an
> A8V-Deluxe, so I don't know why it didn't work. :-( I have the latest Asus
> bios and verified that it is enabled in the BIOS (I know, it doesn't really
> matter, but I mention here).

The patch works on my Asus P4V8X-X board.  There is one problem
though.  With a CMI8738 based PCI sound card in PCI slot 3 the machine
locks up solid when I try to use it.  No problems at all with the card
in slot 2.

-- 
Måns Rullgård
mru@inprovide.com

