Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292725AbSBUTKK>; Thu, 21 Feb 2002 14:10:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292728AbSBUTKA>; Thu, 21 Feb 2002 14:10:00 -0500
Received: from mail.scsiguy.com ([63.229.232.106]:37130 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S292725AbSBUTJw>; Thu, 21 Feb 2002 14:09:52 -0500
Message-Id: <200202211909.g1LJ9mI48542@aslan.scsiguy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: axboe@suse.de (Jens Axboe), scarfoglio@arpacoop.it (Carlo Scarfoglio),
        linux-kernel@vger.kernel.org
Subject: Re: AIC7XXX 6.2.5 driver 
In-Reply-To: Your message of "Thu, 21 Feb 2002 14:01:33 GMT."
             <E16dtmv-0006z2-00@the-village.bc.nu> 
Date: Thu, 21 Feb 2002 12:09:48 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> You should ask Justin whether he has submitted it for inclusion or not.
>> I offered to port to 2.5 at least, but heard nothing.
>
>I was sent a patch for it which included some scsi changes, broke support
>for the CMD ide controllers and didn't apply in the aic7xxx area. So I
>threw it in /dev/null

All I got from you was an email with the text "Thanks!" in it.  I'll
take that to indicate a toss to /dev/null in the future. 8-)

Seriously, if you let me know exactly which version you want my patches
relative to, I'll regenerate them.  From a message Jens sent me, it
sounds like his change to fix a bug I fixed differently had already been
included in certain 2.4.18-pre kernels which was the cause of the patch
not working for him.  I can only assume you ran into the same problem.
My patch was relative to 2.4.17, not a more recent, yet unblessed, kernel.

As to the CMD640 patch.  Can you let me know why you believe it breaks
the CMD640?  The current scheme leaks transactions on the bus and *will*
upset certain controllers that don't expect their register spaces to
be uncerimoniously poked.  Is your complaint that it only handles the
attachment of a single controller?  The old code is no different in this
regard - Scott just had the courtesy to document that this was still not
corrected by this change.  If you need us to fix this other bug too in
order to get the other changes into the tree, just let us know and we'll
do the extra work.

Information about the SCSI mid-layer changes were posted to the SCSI list
and I believe CC'd to you.  If you need that information again, I'd be
happy to resend it.

--
Justin
