Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316690AbSE0Q42>; Mon, 27 May 2002 12:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316693AbSE0Q41>; Mon, 27 May 2002 12:56:27 -0400
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:21402 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S316690AbSE0Q40>; Mon, 27 May 2002 12:56:26 -0400
Date: Mon, 27 May 2002 12:55:47 -0400
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1
Message-ID: <20020527125547.A29216@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Adding CONFIG_XF86_USE_3DNOW=y
>> seems to help a little too.

Mmm, maybe not.

> Make sure you benchmark FPU intensive use when testing USE_3DNOW. I've
> seen several situations where it looks marginally better until you
> actually measure two things - memory bandwidth available to user
> programs, and also FPU performance, especially of FPU heavy apps that
> schedule a lot (eg Quake)

Thanks for helping me narrow the search.  On an allocate and write to 
pages of memory test, USE_3DNOW increased test time by 15% (which is
bad) on k6-2.  

Both kernels compiled with gcc-3.1.0 -march=k6-2.

mtest01 -w 50 executed 100 times 

CONFIG_X86_USE_3DNOW=n	745 seconds
CONFIG_X86_USE_3DNOW=y	860 seconds

-- 
Randy Hron

