Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVDNXBU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVDNXBU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 19:01:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVDNXBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 19:01:19 -0400
Received: from mailhost.readq.com ([166.84.192.124]:43438 "EHLO
	mailhost.readq.com") by vger.kernel.org with ESMTP id S261633AbVDNXAx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 19:00:53 -0400
Message-ID: <425EF60F.9080901@readq.com>
Date: Thu, 14 Apr 2005 19:00:31 -0400
From: Mike Russo <miker@readq.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Serverworks LE and MTRR write-combining question
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

I'd like to begin by humbly thanking everyone who works on the kernel 
for their time and patience and energy. Without you my company would 
have had to spend a lot more on software and gotten nowhere near as much 
value in return!

I have a question regarding my motherboard's serverworks LE chipset and 
MTRR write-combining.
/usr/src/linux/arch/i386/kernel/cpu/mtrr/main.c will not allow 
write-combining because of the potential for data corruption,
but according to the following old LKML post, this is only true for 
certain old revisions of the motherboard:

http://www.ussg.iu.edu/hypermail/linux/kernel/0104.3/1007.html

This person even submitted a patch which looked like it was going to be 
accepted, but nothing happened after that. I checked the output of lspci 
and my revision (06) was the first one where the fix was included, 
according to this person's post. I therefore disabled the check and 
recompiled my kernel (2.6.12-rc2-mm3, which is noticeably faster than 
the default fedora core 3 kernel, with nearly the same configuration). X 
was able to setup a write-combining range (I had to disable one that was 
setup already but it didn't seem to affect anything else) and I've been 
working over four hours (wow!) without any corruption or lockups.  Just 
wondering if anyone had any updates on this issue, and if not, hey, 
that's why the source is there -- for me to screw around with. ;)


-- 
Mike Russo
ReadQ Systems, Inc.
(212) 425 3680 x105

Random quote of the day:
We are sorry.  We cannot complete your call as dialed.  Please check
the number and dial again or ask your operator for assistance.

This is a recording.

