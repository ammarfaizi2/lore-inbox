Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266376AbUHIWx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266376AbUHIWx4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266380AbUHIWx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:53:56 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:50571 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266376AbUHIWxy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:53:54 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Albert Cahalan <albert@users.sf.net>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: alan@lxorguk.ukuu.org.uk, dwmw2@infradead.org,
       schilling@fokus.fraunhofer.de, axboe@suse.de
Content-Type: text/plain
Organization: 
Message-Id: <1092082920.5761.266.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 09 Aug 2004 16:22:01 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
> On Llu, 2004-08-09 at 15:12, Joerg Schilling wrote:
>> [Alan Cox writes]

>>> Linux has capabilities, ACLs and SELinux rulesets which
>>> can also be used to manage this. I can give the cd burner
>>> a role that permits it certain things.
>> 
>> If you are right, why then is SuSE removing the warnings
>> in cdrecord that are there to tell the user that cdrecord
>> is running with insufficient privilleges?
>
> You'd have to ask them. Probably for the reason that most vendors
> remove a lot of the other weird warnings - it confuses end users.

Oh dear my. I'm going to, at least partially, agree with Joerg.
Pigs are cleared for take-off.

The warning about "cdrecord dev=/dev/hdc" is truly crap.
The same goes for "unsettled issues with Linux-2.5". The
other warnings are sane though, and should not be removed.

If the warnings are confusing, they need to be re-worded.
When you remove warnings, users get hurt. The users do  
things that may well fail, and then have no clue why things
are failing.

Shall we rip the printk() calls out of the kernel? Many
of them are weird. They might confuse the end users.

Joerg:
   "WARNING: Cannot do mlockall(2).\n"
   "WARNING: This causes a high risk for buffer underruns.\n"
Fixed:
   "Warning: You don't have permission to lock memory.\n"
   "         If the computer is not idle, the CD may be ruined.\n"

Joerg:
   "WARNING: Cannot set priority class parameters priocntl(PC_SETPARMS)\n"
   "WARNING: This causes a high risk for buffer underruns.\n"
Fixed:
   "Warning: You don't have permission to hog the CPU.\n"
   "         If the computer is not idle, the CD may be ruined.\n"


