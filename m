Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266457AbUHIKQt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266457AbUHIKQt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 06:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266453AbUHIKPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 06:15:45 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:3732 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S266451AbUHIKOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 06:14:10 -0400
Date: Mon, 9 Aug 2004 12:13:26 +0200 (CEST)
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Message-Id: <200408091013.i79ADQK0008995@burner.fokus.fraunhofer.de>
To: axboe@suse.de, schilling@fokus.fraunhofer.de
Cc: James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From axboe@suse.de  Fri Aug  6 17:10:35 2004

>> Let me give you a short answer: If DMA creates so many problem on Linux,
>> how about imlementing a generic DMA abstraction layer like Solaris does?

>We do have that. But suddenly changing the alignment and length
>restrictions on issuing dma to a device in the _end_ of a stable series
>does not exactly fill me with joyful expectations. It's simply that,
>not lack of infrastructure.

If you _really_ _had_ a DMA abstraction layer, then ide-scsi would use DMA
for all sector sizes a CD may have. The fact that ide-scsi does not
use DMA easily proves that you are wrong.


>> Please try to distinct between threads I did start and threads I have
>> been drawn into. I am open to any serious discussion, however if you
>> like to insist in things that have been agreed on being suboptimal for
>> more than 20 years, you should have very good reasons _and_ be willing
>> to explain them.

>Agreed between whom? I don't agree that this naming is sound, in fact I
>think it's quite stupid.

If you like to call the Sun developers and the FreeBSD developers (which means 
people like Bill Joy and Scott Mcusick) stupid, you seem to have a real
strange idea from the world :-(

AGAIN: if you believe you did invent a better method, _describe_ it.
As you did not describe a _working_ method different from the one I request,
you need to agree that you are wrong - as long as your description is missing.



>I am focused on Linux, that's what I work on. And I truly think the
>device naming option is so much easier for users that it's not even
>funny.

So let me use other words: While I am focussed on the cdrtools uses on _all_
platforms, you are not :-(

 
>> As 50% of all problems reported for cdrecord on Linux look like Linux
>> kernel problems, this is what I do every day.

>Just because they look like Linux kernel problems, doesn't mean that
>they are :-)

I am able to distinct between something that only looks like a kernel problem
and something that really is a kernel problem. As long as you define everything
to be a non kernel problem :-( see the Linux Kernel bug with 
SG_SET_RESERVED_SIZE) I don't know how to continue the discussion with you.


>A textual description of the problem is not a fix. Or did I miss the
>patch? If so, I apologize.

Being able to read seems to be a real advantage....

>> The importance could be limited if there were unique instance numbers
>> for ATAPI devices using the same address space as the other SCSI
>> devices.  For now, ide-scsi is really important.

>It's not the same address space, so there is not.

Well you just did prove that forcing people to send SCSI commands via 
non SCSI parts of the kernel is a design bug

>> Let's see whether "Linux" is open enough to listen to the demands of
>> the users......

>We try, when they make sense...

You should learn what "make sense" means, Linux-2.6 is a clear move away from 
the demands of a Linux user who likes to write CDs/DVDs.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  If you don't have iso-8859-1
       schilling@fokus.fraunhofer.de	(work) chars I am J"org Schilling
 URL:  http://www.fokus.fraunhofer.de/usr/schilling ftp://ftp.berlios.de/pub/schily
