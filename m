Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263073AbTEBST7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 14:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263078AbTEBST7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 14:19:59 -0400
Received: from gw.enyo.de ([212.9.189.178]:53765 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S263073AbTEBST5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 14:19:57 -0400
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Announcement] "Exec Shield", new Linux security feature
References: <Pine.LNX.4.44.0305021217090.17548-100000@devserv.devel.redhat.com>
	<Pine.LNX.4.50.0305020948550.1904-100000@blue1.dev.mcafeelabs.com>
	<87llxp43ii.fsf@deneb.enyo.de>
	<Pine.LNX.4.50.0305021126200.1904-100000@blue1.dev.mcafeelabs.com>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: Davide Libenzi <davidel@xmailserver.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>
Date: Fri, 02 May 2003 20:32:19 +0200
In-Reply-To: <Pine.LNX.4.50.0305021126200.1904-100000@blue1.dev.mcafeelabs.com> (Davide
 Libenzi's message of "Fri, 2 May 2003 11:29:11 -0700 (PDT)")
Message-ID: <87fznx42to.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1001 (Gnus v5.10.1) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi <davidel@xmailserver.org> writes:

> On Fri, 2 May 2003, Florian Weimer wrote:
>
>> Davide Libenzi <davidel@xmailserver.org> writes:
>>
>> > Ingo, do you want protection against shell code injection ? Have the
>> > kernel to assign random stack addresses to processes and they won't be
>> > able to guess the stack pointer to place the jump.
>>
>> If your software is broken enough to have buffer overflow bugs, it's
>> not entirely unlikely that it leaks the stack address as well (IIRC,
>> BIND 8 did).
>
> Leaking the stack address is not a problem in this case, since the next
> run will be very->very->very likely different.

Usually, you can't afford a fork() and execve() for each request you
process. 8-(

(In addition, GCC might optimize away those alloca() calls.)
