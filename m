Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751378AbVHVWXr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751378AbVHVWXr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Aug 2005 18:23:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbVHVWXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Aug 2005 18:23:09 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:54152 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751337AbVHVWWw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Aug 2005 18:22:52 -0400
To: =?iso-8859-1?q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
Cc: Linh Dang <linhd@nortel.com>, linux-kernel@vger.kernel.org
Subject: Re: Environment variables inside the kernel?
References: <4fec73ca050818084467f04c31@mail.gmail.com>
	<m2ek8r5hhh.fsf@Douglas-McNaughts-Powerbook.local>
	<wn5slx75cjs.fsf@linhd-2.ca.nortel.com>
	<4fec73ca05081811488ec518e@mail.gmail.com>
	<m1fyt3ueh9.fsf@ebiederm.dsl.xmission.com>
	<4fec73ca05082202051231bf15@mail.gmail.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 22 Aug 2005 03:18:40 -0600
In-Reply-To: <4fec73ca05082202051231bf15@mail.gmail.com> (
 =?iso-8859-1?q?Guillermo_L=F3pez_Alejos's_message_of?= "Mon, 22 Aug 2005
 11:05:32 +0200")
Message-ID: <m1r7cmtjm7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guillermo López Alejos <glalejos@gmail.com> writes:

> On 8/22/05, Eric W. Biederman <ebiederm@xmission.com> wrote:
>> ??
>> Usually when I hear stand-alone program I think of program that runs
>> without the need of a kernel.  You have an environment in that context?
>
> Without the need of a kernel? 

Yep I think of programs like memtest86 when I think of stand-alone
programs.

> Perhaps I did not explain myself  correctly... I meant a user space
> program, is that better? 

Yes, thanks.

> And yes, there is a environment in this context, but it is feasible to
> provide the information it contains through module parameters.
>
>> Be very careful.  Generally I think at least until the filesystem
>> is very stable running your filesystem server in the kernel is a mistake.
>> 
>> And the concept of a parallel filesystem with just one server just
>> sounds wrong from any context.
>
> Thanks for the advise, but do not worry, the servers run outside the
> kernel (preferably outside the host :). It is the client side what is
> to be integrated into the kernel.

Ok. As for parameters I would expect most of them to be mount options.

Just a bit of food for thought.  There seem to be two different kinds
of workloads for non-local filesystems.  Bandwidth intensive workloads
where files are read and written.  Cache intensive workloads (like
kernel compiles) where performance directly relates to how
efficiently you can make use of the page cache, and not get buried
in cache contention.

Eric
