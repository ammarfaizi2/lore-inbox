Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262731AbTCJFjV>; Mon, 10 Mar 2003 00:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262732AbTCJFjU>; Mon, 10 Mar 2003 00:39:20 -0500
Received: from pop.gmx.de ([213.165.64.20]:52277 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S262731AbTCJFjU>;
	Mon, 10 Mar 2003 00:39:20 -0500
Message-Id: <5.2.0.9.2.20030310064654.00cf2c40@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 10 Mar 2003 06:54:33 +0100
To: rwhron@earthlink.net
From: Mike Galbraith <efault@gmx.de>
Subject: Re: scheduler starvation running irman with 2.5.64bk2
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5.2.0.9.2.20030310054319.00ceedd0@pop.gmx.net>
References: <20030309025015.GA2843@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 05:46 AM 3/10/2003 +0100, Mike Galbraith wrote:
>P.S.  You can save a little time by only running the process load.  Edit 
>irman.c:412 and set load_num to 3... no need to wait for the other two 
>loads to complete first, it's the process load that starves the box to 
>death here.

P.P.S. (last one;)

To make it cease and desist starving your box, renice the shell you're 
running irman from.  12 is the magic (hmm) number here at which starvation 
ceases.

It's interesting to watch the response times irman reports.  The higher the 
renice level, the better response times it reports both in 2.5.64-virgin, 
and 2.5.64-combo (which looks like what is in bk2).  /me has no clue 
whether that means anything or not ;-)

         ciao,

         -Mike 

