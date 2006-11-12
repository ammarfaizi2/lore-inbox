Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753065AbWKLUQp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbWKLUQp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 15:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753073AbWKLUQp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 15:16:45 -0500
Received: from fest.stud.feec.vutbr.cz ([147.229.72.16]:16592 "EHLO
	fest.stud.feec.vutbr.cz") by vger.kernel.org with ESMTP
	id S1753068AbWKLUQp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 15:16:45 -0500
Message-ID: <45578126.2000306@stud.feec.vutbr.cz>
Date: Sun, 12 Nov 2006 21:16:38 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Icedove 1.5.0.7 (X11/20061013)
MIME-Version: 1.0
To: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: privilege level of program which is called by call_usermodehelper()
References: <20061112190848.37896.qmail@web27401.mail.ukl.yahoo.com>
In-Reply-To: <20061112190848.37896.qmail@web27401.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ranjith kumar wrote:
> Hi,
> 
> I think  the program which is called by
> call_usermodehelper() will not  be executed at
> privilege level zero on IA-32 machines. 
> Am I right?

Right. Only the kernel runs in privilege level (ring) 0.

> How to run a program which has been compiled by a
> compiler(say gcc) at privilege level zero?

You don't. Well, you could put it in the kernel...

> Indeed I  want to compare time taken in executing two
> programs. If we run them at privilege level zero by
> calling them in a kernel module, processor will not
> switch to other processors.

That's a false assumption. Even kernel code is preemptible nowadays.

> So that we can find out
> time taken to execute a program more accurately.

If you run your program on an otherwise idle machine, the results should 
be pretty accurate.
If you really think it matters, then run your program with real-time 
priority.

> What you say??
> Thanks in advance.

Michal
