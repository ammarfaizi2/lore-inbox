Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317394AbSFHKWQ>; Sat, 8 Jun 2002 06:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317395AbSFHKWP>; Sat, 8 Jun 2002 06:22:15 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:37898 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317394AbSFHKWP>;
	Sat, 8 Jun 2002 06:22:15 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Athanasius <link@gurus.tf>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel: request_module[net-pf-10]: fork failed, errno 11 
In-Reply-To: Your message of "Sat, 08 Jun 2002 10:43:07 +0100."
             <20020608094307.GA6522@miggy.org.uk> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 08 Jun 2002 20:22:05 +1000
Message-ID: <21483.1023531725@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jun 2002 10:43:07 +0100, 
Athanasius <link@gurus.tf> wrote:
>  I'm seeing a lot of:
>
>	kernel: request_module[net-pf-10]: fork failed, errno 11
>
>in syslog, despite the fact I a) I have no IPv6 compiled in the kernel,
>and b) have "alias net-pf-10 off             # IPv6" in
>/etc/modules.conf.
>  This is using a stock 2.4.18 kernel.  I was under the impression that
>the /etc/modules.conf line would lead to such things as above not
>happening.  Is the network code doing something slightly askew with
>modules?

That error is occurring before modprobe has run, long before it gets to
modules.conf.  You need to find out why fork() for modprobe on your
system is failing with EAGAIN.  Have you reached the limit on the
number of tasks?

