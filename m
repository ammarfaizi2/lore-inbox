Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263963AbUDFSuU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 14:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263971AbUDFSuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 14:50:20 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:9732 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263963AbUDFSuH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 14:50:07 -0400
Message-ID: <407300C3.9050109@techsource.com>
Date: Tue, 06 Apr 2004 15:10:59 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
CC: Jesse Pollard <jesse@cats-chateau.net>, linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
References: <20040405234957.69998.qmail@web40509.mail.yahoo.com>	<20040406132750$3d4e@grapevine.lcs.mit.edu> <s5gisgd9ipj.fsf@patl=users.sf.net>
In-Reply-To: <s5gisgd9ipj.fsf@patl=users.sf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patrick J. LoPresti wrote:

> Whether it is a good idea in this context is another question.  My
> concern is that it is hard (impossible?) to bound the memory
> consumption, both stack AND heap, of a Lisp program statically.  I
> would expect such bounds to be important for an implementation of a
> security model.  With a Lisp program, you cannot be sure under what
> conditions it will exceed whatever space you have alloted for it.
> Which means that, although it cannot crash the kernel, it cannot be
> used to build a reliable system, either...
> 

I think 100K is rather large for an interpretor to be included in the 
kernel, but putting that aside...

It's a limited number of people who would actually write these policies. 
  If those people follow certain coding rules, then we CAN have such 
bounds, by convention.  Yes, those bounds could be violated, but if the 
programmer (not sysadmin -- they would never write these things in LISP) 
breaks something, it's just a bug.

Mostly it would be kernel programmers who write the policies, and those 
would appear in some /etc directory, put there by Red Hat, and 
selectable by admins using some GUI.

Someone writing a policy which caused the VM to explode would be no 
different from nVidia writing a kernel driver which did it more directly.

The advantage of scripting the policy (which is essentially what this 
is) is that they could be switchable more dynamically, and they could 
refer to kernel structures more abstractly.

