Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263291AbVBDUol@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263291AbVBDUol (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 15:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264408AbVBDUf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 15:35:26 -0500
Received: from alog0095.analogic.com ([208.224.220.110]:1408 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S264629AbVBDUWY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 15:22:24 -0500
Date: Fri, 4 Feb 2005 15:22:25 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Rahul Jain <rbj2@oak.njit.edu>
cc: Kernel Traffic Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to add source files in kernel
In-Reply-To: <Pine.GSO.4.58.0502041408540.12006@chrome.njit.edu>
Message-ID: <Pine.LNX.4.61.0502041519220.5805@chaos.analogic.com>
References: <Pine.GSO.4.58.0502041408540.12006@chrome.njit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Feb 2005, Rahul Jain wrote:

> Hi All,
>
> I am trying to add 2 new files (a .h and a .c) in the kernel. I copied my
> .h file in /include/linux and .c in /net/core. I then made the
> following change to the Makefile in /net/core.
>
> obj-y := sock.o skbuff.o iovec.o datagram.o scm.o split_helper.o
>
> where split_helper.o is for the .c file that I am adding.
>
> The kernel recompilation went without any problems. I wrote loadable
> module programs that can access the functions defined in .c. When I try to
> install these modules, they came back with the following error
>
> /sbin/insmod x.o
> x.o: unresolved symbol enqueue_sfi
> x.o: unresolved symbol init_skbuff_list
> x.o: unresolved symbol get_head_sfi
> x.o: unresolved symbol search_sfi
> x.o: unresolved symbol enqueue_skbuff_list
> x.o: unresolved symbol init_head_sfi
> x.o:
> Hint: You are trying to load a module without a GPL compatible license
>      and it has unresolved symbols.  Contact the module supplier for
>      assistance, only they can help you.
>
> make: *** [install] Error 1
>
> These functions are defined in the .c file and declared with the extern
> keyword in the .h file. In my modules I am including the .h file.
>
> Any suggestions on what I might be missing here ?
>
> Thanks,
> Rahul.

MODULE_LICENSE("GPL");

Needs to be in one of your files. This is part of the
"New World Order".

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
