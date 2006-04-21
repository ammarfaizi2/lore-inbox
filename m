Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWDUFKs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWDUFKs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 01:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWDUFKs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 01:10:48 -0400
Received: from ishtar.tlinx.org ([64.81.245.74]:38793 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S932247AbWDUFKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 01:10:47 -0400
Message-ID: <4448694E.90508@tlinx.org>
Date: Thu, 20 Apr 2006 22:10:38 -0700
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Christoph Hellwig <hch@infradead.org>,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export namespace	semaphore
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com> <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil> <20060420124647.GD18604@sergelap.austin.ibm.com> <1145534735.3313.3.camel@moss-spartans.epoch.ncsc.mil> <20060420132128.GG18604@sergelap.austin.ibm.com> <1145537318.3313.40.camel@moss-spartans.epoch.ncsc.mil> <44480727.9010500@tlinx.org> <20060420230551.GA5026@infradead.org> <4448355F.7070509@tlinx.org> <20060421020929.GG3828@sorel.sous-sol.org>
In-Reply-To: <20060421020929.GG3828@sorel.sous-sol.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Chris Wright wrote:
> * Linda A. Walsh (law@tlinx.org) wrote:  
>>    "The *current* accepted way to get pathnames going into system 
>> calls is
>> to put a trap in the syscall vector processing code to be indirectly
>> called through the ptrace call with every system call as audit 
>> currently does..."?
>>
>>    Or is that not correct either? 
> No it's not.  See getname(9).

   I'm familiar with the getname call, it's probably the case that
audit calls getname to do the actual copy from user->kernel space, I
haven't checked.  But I can't find the manpage you are referring to.

I may be suffering from impaired "colloquialisms" in my writing, but
I was referring to the process of collecting pathnames for use in
a security policy (ex. audit, systrace or AppArmor) for the
kernel calls that take one or more pathnames being done via code
inserted into the system call code that is called with each system
call.

Whatever policy (audit, AppArmor, etc) is in place is then called
on every syscall and each policy then decides what actual
system calls it is interested in and then does call specific
argument processing to make a record of or enforce policy.

The argument processing would likely involve getname() to retrieve
the path from user space.

Is there something specific on the getname manpage you are
referring to or are we talking about the same thing?

Thanks for the clarification...:-)
Linda
 
