Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312677AbSCVFtg>; Fri, 22 Mar 2002 00:49:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312672AbSCVFt0>; Fri, 22 Mar 2002 00:49:26 -0500
Received: from mail.webmaster.com ([216.152.64.131]:52157 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S311294AbSCVFtS> convert rfc822-to-8bit; Fri, 22 Mar 2002 00:49:18 -0500
From: David Schwartz <davids@webmaster.com>
To: <joeja@mindspring.com>,
        "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (1003) - Registered Version
Date: Thu, 21 Mar 2002 21:49:15 -0800
In-Reply-To: <RELAY2HXrsOZoybKw2N00004110@relay2.softcomca.com>
Subject: Re: max number of threads on a system
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020322054916.AAA14361@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 21 Mar 2002 20:05:39 -0500, joeja@mindspring.com wrote:
>What limits the number of threads one can have on a Linux system?

	Common sense, one would hope.

>I have a simple program that creates an array of threads and it locks up at
>the creation of somewhere between 250 and 275 threads.

	If it locks up, that's a bug. I remember older versions of glibc actually 
had this bug. But it should simply fail to create them.

>The program just hangs indefinately unless a Control-C is hit.
>
>How can I increase this number or can I?

	Why increase the number of threads you can create before you trigger a bug? 
Wouldn't it make more sense to *fix* the bug so that pthread_create returns 
an error like it's supposed to?

	In any event, don't create so many threads. Create threads only to keep CPUs 
busy or to pend I/Os that can't be done asynchronously.

	DS


