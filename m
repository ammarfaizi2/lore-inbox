Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262955AbVBDTTQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262955AbVBDTTQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 14:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265072AbVBDTR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:17:28 -0500
Received: from mail-gw4.njit.edu ([128.235.251.32]:37566 "EHLO
	mail-gw4.njit.edu") by vger.kernel.org with ESMTP id S265688AbVBDTRL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 14:17:11 -0500
Date: Fri, 4 Feb 2005 14:17:10 -0500 (EST)
From: Rahul Jain <rbj2@oak.njit.edu>
To: Kernel Traffic Mailing List <linux-kernel@vger.kernel.org>
Subject: How to add source files in kernel
Message-ID: <Pine.GSO.4.58.0502041408540.12006@chrome.njit.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I am trying to add 2 new files (a .h and a .c) in the kernel. I copied my
.h file in /include/linux and .c in /net/core. I then made the
following change to the Makefile in /net/core.

obj-y := sock.o skbuff.o iovec.o datagram.o scm.o split_helper.o

where split_helper.o is for the .c file that I am adding.

The kernel recompilation went without any problems. I wrote loadable
module programs that can access the functions defined in .c. When I try to
install these modules, they came back with the following error

/sbin/insmod x.o
x.o: unresolved symbol enqueue_sfi
x.o: unresolved symbol init_skbuff_list
x.o: unresolved symbol get_head_sfi
x.o: unresolved symbol search_sfi
x.o: unresolved symbol enqueue_skbuff_list
x.o: unresolved symbol init_head_sfi
x.o:
Hint: You are trying to load a module without a GPL compatible license
      and it has unresolved symbols.  Contact the module supplier for
      assistance, only they can help you.

make: *** [install] Error 1

These functions are defined in the .c file and declared with the extern
keyword in the .h file. In my modules I am including the .h file.

Any suggestions on what I might be missing here ?

Thanks,
Rahul.
