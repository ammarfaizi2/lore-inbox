Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263070AbTCWOfY>; Sun, 23 Mar 2003 09:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263071AbTCWOfY>; Sun, 23 Mar 2003 09:35:24 -0500
Received: from [196.12.44.6] ([196.12.44.6]:21183 "EHLO students.iiit.net")
	by vger.kernel.org with ESMTP id <S263070AbTCWOfX>;
	Sun, 23 Mar 2003 09:35:23 -0500
Date: Sun, 23 Mar 2003 20:16:43 +0530 (IST)
From: Prasad <prasad_s@students.iiit.net>
To: shesha bhushan <bhushan_vadulas@hotmail.com>
cc: linux-kernel@vger.kernel.org, <kernelnewbies@nl.linux.org>
Subject: Re: inet_addr Equivalent
In-Reply-To: <F110LwR2ozm2F4mOKbA0000952b@hotmail.com>
Message-ID: <Pine.LNX.4.44.0303232013240.11069-100000@students.iiit.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


may be you can write your own function... I had my implementation that 
works, it should for you too...  just take a look at the bottom.

> IF i want to use the inet_addr in kernel modules, then how to use. What is 
> the equivalent function to this or which is the header file that I have to 
> include. If I include "arpa/inet.h" and compile as kernel module, I gives 
> whole bunch of errors.


	unsigned int inet_addr(char *str)
	{
	  int a,b,c,d;
	  char arr[4];
	  sscanf(str,"%d.%d.%d.%d",&a,&b,&c,&d);
	  arr[0] = a; arr[1] = b; arr[2] = c; arr[3] = d;
	  return *(unsigned int*)arr;
	}

Prasad.

-- 
Failure is not an option

