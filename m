Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263213AbUDEVKH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263211AbUDEVHz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:07:55 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:3596 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S263199AbUDEVHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:07:37 -0400
Message-ID: <4071CF6E.4030104@techsource.com>
Date: Mon, 05 Apr 2004 17:28:14 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
CC: John Stoffel <stoffel@lucent.com>, Helge Hafting <helgehaf@aitel.hist.no>,
       linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
References: <20040405205412.60071.qmail@web40504.mail.yahoo.com>
In-Reply-To: <20040405205412.60071.qmail@web40504.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Sergiy Lozovsky wrote:

> 
> 
> All LISP errors are incapsulated within LISP VM.
>  


A LISP VM is a big, giant, bloated.... *CHOKE* *COUGH* *SPUTTER* 
*SUFFOCATE* ... thing which SHOULD NEVER be in the kernel.

If you want to use a more abstract language for describing kernel 
security policies, fine.  Just don't use LISP.

The right way to do it is this:

- A user space interpreter reads text-based config files and converts 
them into a compact, easy-to-interpret code used by the kernel.

- A VERY TINY kernel component is fed the security policy and executes it.


Move as much of the processing as reasonable into user space.  It's 
absolutely unnecessary to have the parser into the kernel, because 
parsing of the config files is done only when the ASCII text version 
changes.

It's absolutely unnecessary to have something as complex as LISP to 
interpret it, when something simple and compact could do just as well.

Why do you choose LISP?  Don't you want to use a language that sysadmins 
will actually KNOW?

