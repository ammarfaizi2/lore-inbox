Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbUCSNF3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 08:05:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262862AbUCSNF3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 08:05:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:59790 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262952AbUCSNFW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 08:05:22 -0500
Date: Fri, 19 Mar 2004 08:06:51 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
cc: linux-kernel@vger.kernel.org
Subject: Re: Is there any difference between SMP makefile and non SMP makefile
In-Reply-To: <1118873EE1755348B4812EA29C55A972176922@esnmail.esntechnologies.co.in>
Message-ID: <Pine.LNX.4.53.0403190758430.763@chaos>
References: <1118873EE1755348B4812EA29C55A972176922@esnmail.esntechnologies.co.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Mar 2004, Srinivas G. wrote:

>
> Hello,
>
> I am using Red Hat Linux 7.3, Kernel is 2.4.18-3smp and kernel 2.4.18-3
> under Intel HT processor.
>
> Is there any difference between SMP Makefile and non SMP Makefile. I
	NO
> have Makefile for non SMP system. What macros OR what flags can I add to
> the existing Makefile to compile it on 2.4.18-3smp kernel. It is working
> fine under 2.4.18-3 kernel that is non-SMP system.
>
> Thanks in advance.
>
> ---Srinivas G
>

You do not modify the Makefile. You grab the ".config" file with
which the existing code was compiled, search for "CONFIG_SMP".
Change it from:
"# CONFIG_SMP is not set"
 to:
"CONFIG_SMP=y".
Then execute `make clean ; make oldconfig`. Then make
bzImage (or whatever). This is a reversible procedure.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


