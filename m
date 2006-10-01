Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932068AbWJARUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932068AbWJARUs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWJARUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:20:48 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:52111 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932068AbWJARUr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:20:47 -0400
Message-ID: <451FF8ED.9080507@garzik.org>
Date: Sun, 01 Oct 2006 13:20:45 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Randy Dunlap <rdunlap@xenotime.net>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: Announce: gcc bogus warning repository
References: <451FC657.6090603@garzik.org> <20061001100747.d1842273.rdunlap@xenotime.net>
In-Reply-To: <20061001100747.d1842273.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap wrote:
> On Sun, 01 Oct 2006 09:44:55 -0400 Jeff Garzik wrote:
> 
>> The level of warnings in a kernel build has lately increased to the 
>> point where it is hiding bugs and otherwise making life difficult.
>>
>> In particular, recent gcc versions throw warnings when it thinks a 
>> variable "MAY be used uninitialized", which is not terribly helpful due 
>> to the fact that most of these warnings are bogus.
>>
>> For those that may find this valuable, I have started a git repo that 
>> silences these bogus warnings, after careful auditing of code paths to 
>> ensure that the warning truly is bogus.
>>
>> The results may be found in the "gccbug" branch of
>> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/misc-2.6.git
>>
>> This repository will NEVER EVER be pushed upstream.  It exists solely 
>> for those who want to decrease their build noise, thereby exposing true 
>> bugs.
>>
>> The audit has already uncovered several minor bugs, lending credence to 
>> my theory that too many warnings hides bugs.
> 
> I usually build with must_check etc. enabled then grep them
> away if I want to look for other messages.  I think that the situation
> is not so disastrous.

I think it's both sad, and telling, that the high level of build noise 
has trained kernel hackers to tune out warnings, and/or build tools of 
ever-increasing sophistication just to pick out the useful messages from 
all the noise.

If you have to grep useful stuff out of the noise, you've already lost.

	Jeff



