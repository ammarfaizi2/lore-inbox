Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316247AbSEVQ4m>; Wed, 22 May 2002 12:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316253AbSEVQ4l>; Wed, 22 May 2002 12:56:41 -0400
Received: from www.cdhutmusic.co.sz ([196.28.7.66]:15031 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S316247AbSEVQ4h>; Wed, 22 May 2002 12:56:37 -0400
Date: Wed, 22 May 2002 18:31:27 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: lylai <lylai@csie.nctu.edu.tw>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: multithreaded device driver
In-Reply-To: <1022086063.9911.4.camel@chiayi.csie.nctu.edu.tw>
Message-ID: <Pine.LNX.4.44.0205221829430.23578-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 May 2002, lylai wrote:

> Does linux kernel provide kernel level thread headers that I can use to
> write a multithreaded device driver?
> 
> Do I need to program a device driver to be multithreaded to achieve
> paralle I/O?
> 
> Thank you for your help.

Worth looking at linux/drivers/net/8139too.c, that uses threads. Other 
methods of offloading work from a central point like an ISR could be done 
with Bottom Halves (tasklets) but that won't be parallelised.

Not conclusive, but hope it helps.
	Zwane Mwaikambo

-- 
http://function.linuxpower.ca
		

