Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264475AbTEJTVa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 15:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264477AbTEJTV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 15:21:29 -0400
Received: from siaag1ad.compuserve.com ([149.174.40.6]:13792 "EHLO
	siaag1ad.compuserve.com") by vger.kernel.org with ESMTP
	id S264475AbTEJTV2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 15:21:28 -0400
Date: Sat, 10 May 2003 15:32:00 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: The disappearing sys_call_table export.
To: "arjanv@redhat.com" <arjanv@redhat.com>
Cc: Ahmed Masud <masud@googgun.com>, Terje Eggestad <terje.eggestad@scali.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Jesse Pollard <jesse@cats-chateau.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200305101532_MC3-1-3853-24B6@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

> I'm pretty sure that auditing by your module can easily be avoided.
>
> examle: pseudocode for the unlink syscall
>
> long your_wrapped_syscall(char *userfilename)
> {
>     char kernelpointer[something];
>     copy_from_user(kernelpointer, usefilename, ...);
>     audit_log(kernelpointer);
>     return original_syscall(userfilename);
> }

  Great, now how do you plan to get that code loaded into memory on
my configuration? (no modules, /dev/kmem unwriteable) (or ipd driver
loaded on NT/2K)

> The only solution for this is to check/audit/log things after the ONE
> copy. Eg not by overriding the syscall but inside the syscall.

  If I can alter kernel memory I can patch out your auditing code.
It's just more difficult if you try to hide it inside the syscall.  :)


