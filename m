Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264028AbUDFVG5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 17:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264020AbUDFVEX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 17:04:23 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:58373 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264009AbUDFVDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 17:03:42 -0400
Message-ID: <40732013.8090400@techsource.com>
Date: Tue, 06 Apr 2004 17:24:35 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
CC: Jesse Pollard <jesse@cats-chateau.net>, linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
References: <20040405234957.69998.qmail@web40509.mail.yahoo.com>	<20040406132750$3d4e@grapevine.lcs.mit.edu>	<s5gisgd9ipj.fsf@patl=users.sf.net> <407300C3.9050109@techsource.com> <s5gd66kamde.fsf@patl=users.sf.net>
In-Reply-To: <s5gd66kamde.fsf@patl=users.sf.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Patrick J. LoPresti wrote:

>>It's a limited number of people who would actually write these
>>policies. If those people follow certain coding rules, then we CAN
>>have such bounds, by convention.  Yes, those bounds could be violated,
>>but if the programmer (not sysadmin -- they would never write these
>>things in LISP) breaks something, it's just a bug.
> 
> 
> Fair enough.  But then I wonder how many of Lisp's advantages you
> would lose.  I am having trouble imagining "statically bounded Lisp"
> without being so stylized as to hardly be Lisp at all.
> 

Given that the original author admits that the sysadmins using this 
would never actually write any LISP code, I too fail to see why LISP 
would be of any help here.

If you want to be compact and efficient, some really simple 
pseudo-language would do the job well enough.  Optimize for speed of 
execution and compactness of both interpreter and policy code, not for 
easy of writing in the language.

I mean, by choosing LISP, "ease of writing in the language" was thrown 
out the window to begin with!  :)

I think this points us in the direction of something like Forth.  Take 
OpenBoot for example.  I wrote Forth-like interpreters in Pascal when I 
was in highschool.

But if you DO want sysadmins to be able to write this, then something 
resembling shell script would be better.  It wouldn't be quite like 
shell scripting, but it would LOOK like it, and it would have to be 
compiled (by the program that you run to load the policy) into something 
compact and easy to interpret before being fed to the kernel.

Another possibility is to develop a set of tools that compile policies 
written in C into modules that are loaded/unloaded into the kernel 
dynamically.  :)   The compile process would be transparent to the user, 
because the "insert this policy" tool would run it through GCC (unless 
the cached .ko was already up to date, etc.).


