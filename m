Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316604AbSFJU7R>; Mon, 10 Jun 2002 16:59:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316600AbSFJU7P>; Mon, 10 Jun 2002 16:59:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:41868 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S316484AbSFJU6b>; Mon, 10 Jun 2002 16:58:31 -0400
Date: Mon, 10 Jun 2002 13:58:30 -0700 (PDT)
From: Nivedita Singhvi <niv@us.ibm.com>
X-X-Sender: <nivedita@w-nivedita2.des.beaverton.ibm.com>
To: <cplusplushelp@gmx.net>
cc: <linux-kernel@vger.kernel.org>
Subject: removing old SYN packets
Message-ID: <Pine.LNX.4.33.0206101343160.26549-100000@w-nivedita2.des.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I need some information about the TCP implementation. I didn't 
> find any information in my Linux Kernel book or in any other 
> tutorial about TCP and I do not really understand the tcp.c

> The kernel should remove SYN packets if it doesn't recive the 
> final ACK. But where is that implemented in the Linux Kernel?

when the synack timer goes off and it has retried enough times
(at least sysctl_tcp_synack_retries times or the max that was
set for the connection).

see timer.c: tcp_synack_timer() stuff

thanks,
Nivedita

