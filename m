Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261978AbSJJSIa>; Thu, 10 Oct 2002 14:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbSJJSIa>; Thu, 10 Oct 2002 14:08:30 -0400
Received: from mailman.xyplex.com ([140.179.176.116]:17563 "EHLO
	mailman.xyplex.com") by vger.kernel.org with ESMTP
	id <S261978AbSJJSI3>; Thu, 10 Oct 2002 14:08:29 -0400
Message-ID: <19EE6EC66973A5408FBE4CB7772F6F0A046A3D@ltnmail.xyplex.com>
From: "Dow, Benjamin" <bdow@itouchcom.com>
To: "'Manfred Spraul'" <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org, "'rml@tech9.net'" <rml@tech9.net>
Subject: RE: kernel memory leak?
Date: Thu, 10 Oct 2002 14:09:58 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>  >
>  > /proc/slabinfo reports that buffer_head increases by 4k, but
>  > those are the only changes)
>  >
> 4k or one object? the first column ist the number of objects, not 4k.
> 

My mistake; I didn't understand slabinfo very well at the time... and
(embarassingly enough) that was related to my piping the output to a file
(in order to do a diff later) rather than a regularly-occurring phenomenon.

As for my memory leak problem, I did finally track it down to the
kernel-preemption patch... my best guess is that it interacts poorly with
some of our platform-specific modifications... though what I can't figure
out is why even with preemption disabled (in menuconfig), I still have the
problem.  I'm looking through the patch again to try to find additions that
aren't #ifdef'd out when it's disabled, but I have a feeling that since I've
found a way to fix the problem, I'll be moving on to other things soon.
<sigh>

Anyway, thanks to everyone who offered advice, and if any kernel preemption
experts want to set me straight, feel free!

Ben

(oh, and I apologize for the signature that the mail server apparently just
started appending to my messages... I can't do anything about it)
(how about that, a disclaimer for a disclaimer?)



 The information contained in this electronic mail is privileged and
confidential, intended only for the use of the individual or entity named
above. If the reader of this message is not the intended recipient, you are
hereby notified that any dissemination, distribution, copying or other use
of this communication is strictly prohibited. 
