Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265696AbSJSW1x>; Sat, 19 Oct 2002 18:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265697AbSJSW1x>; Sat, 19 Oct 2002 18:27:53 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:47122 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265696AbSJSW1w>; Sat, 19 Oct 2002 18:27:52 -0400
Path: Home.Lunix!not-for-mail
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
Date: Sat, 19 Oct 2002 22:36:30 +0000 (UTC)
Organization: lunix confusion services
References: <200210190352.WAA05769@ccure.karaya.com>
NNTP-Posting-Host: kali.eth
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Trace: quasar.home.lunix 1035066990 24846 10.253.0.3 (19 Oct 2002
    22:36:30 GMT)
X-Complaints-To: abuse-0@ton.iguana.be
NNTP-Posting-Date: Sat, 19 Oct 2002 22:36:30 +0000 (UTC)
X-Newsreader: knews 1.0b.0
Xref: Home.Lunix mail.linux.kernel:188371
X-Mailer: Perl5 Mail::Internet v1.33
Message-Id: <aosmpe$o8e$1@post.home.lunix>
From: linux-kernel@ton.iguana.be (Ton Hospel)
To: linux-kernel@vger.kernel.org
Reply-To: linux-kernel@ton.iguana.be (Ton Hospel)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <200210190352.WAA05769@ccure.karaya.com>,
	Jeff Dike <jdike@karaya.com> writes:
> 
> This needs to be virtualizable somehow, which means that apps run inside
> UML, without being changed, get the UML vsyscalls.  There are a couple of
> possiblities that I can think of:
> 	a get_vsyscall system call which is executed by libc on startup -
> UML would return a different calue from the host
> 	some mechanism for UML to map its own vsyscall area in place of
> the host's - it wouldn't necessarily need to be able to unmap it when it's
> running its own kernel code because it can probably arrange not to use the
> host's vsyscalls.
> 
> 				Jeff
> 
In case you want UML to also be able to work as a jail, it should
actually be impossible to get to the "real" systemcalls. In that case
just asking libc is not acceptable if the other area remains available
