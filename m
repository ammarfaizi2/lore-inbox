Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751493AbWCSM7E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbWCSM7E (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 07:59:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbWCSM7D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 07:59:03 -0500
Received: from main.gmane.org ([80.91.229.2]:37251 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751493AbWCSM7D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 07:59:03 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: [PATCH 001/001] PCI: PCI quirk for Asus A8V and A8V Deluxe motherboards
Date: Sun, 19 Mar 2006 12:58:50 +0000
Message-ID: <yw1xd5gi381h.fsf@agrajag.inprovide.com>
References: <20060305192709.GA3789@skyscraper.unix9.prv> <dve3j9$r50$1@sea.gmane.org> <20060317143303.GR20746@lug-owl.de> <dvehv7$j9r$1@sea.gmane.org> <20060317144920.GS20746@lug-owl.de> <dveugj$aob$1@sea.gmane.org> <yw1xmzfo98em.fsf@agrajag.inprovide.com> <dvh3rb$ui8$1@sea.gmane.org> <yw1x64mb7rwm.fsf@agrajag.inprovide.com> <dvh7aj$95v$1@sea.gmane.org> <yw1xoe0368yj.fsf@agrajag.inprovide.com> <dvjcb4$as2$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 82.153.166.94
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.15 (linux)
Cancel-Lock: sha1:eaaglvc149Ut4WeMB38bzspZ84U=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andras Mantia <amantia@kde.org> writes:

> Måns Rullgård wrote:
>> Hmm, mine crashed when I used the PCI card.  Using the onboard sound
>> was fine.
>
> Now it doesn't crash. :-0 That hang was with kernel 2.6.15, but I switeched
> back to 2.6.13 as that is what suse provides and I played some music on
> both cards and tried Skype on the onboard card (there was the hang) and it
> was OK.

Just write it off to cosmic rays if it doesn't happen again.

>>>>> Can you tell me how can I find the real device ID for my chipset? It
>>>>> *should* be the same one as the original writer of the patch wrote (he
>>>>> also had an ASUS A8V Deluxe as I understood), but the experience tells
>>>>> it is not.
>>>> 
>>>> lspci -n will list the PCI IDs in hex.
>>>
>>> Thanks.
>> 
>> Care to post the output?
>
> Sure. I still don't know how to use those numbers in the quircks.c  (do I
> need to create something like #define PCI_DEVICE_WHATEVER pciIDNumber ?).

The device IDs are already #defined in <linux/pci_ids.h>.

> The result of lspci -vvvn is attached.

> 00:11.0 Class 0601: 1106:3227
> 	Subsystem: 1043:80ed

This is the interesting bit.  Curiously enough, it is exactly the same
as mine.  I can't see any reason why it shouldn't match on your board.

Try sticking some printk()s in there and find out what values are
actually seen.

-- 
Måns Rullgård
mru@inprovide.com

