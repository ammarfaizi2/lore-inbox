Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310979AbSCHSDz>; Fri, 8 Mar 2002 13:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310980AbSCHSDr>; Fri, 8 Mar 2002 13:03:47 -0500
Received: from smtp.terrabee.net ([213.242.165.28]:51724 "HELO
	smtp.terrabee.net") by vger.kernel.org with SMTP id <S310979AbSCHSDc>;
	Fri, 8 Mar 2002 13:03:32 -0500
Message-ID: <3C88FCED.5030407@computer.org>
Date: Fri, 08 Mar 2002 19:03:25 +0100
From: Robert Claeson <r.claeson@computer.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020212
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Problem with Kernel
In-Reply-To: <20020304164444.A263@romulus>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy M. Totten wrote:

 >    I am currently running Kernel 2.4.5 on my machine, and I
 >tried to install 2.4.18 and got a kernel panic. So I thought
 >I'de just make a new compile of 2.4.5 with only one change,
 >I set the High Memory support to 4GB instead of None.
 >
 >    Right when the kernel should have been setting up the swap
 >space, instead it gave me the following message:
 >
 >BUG IN DYNAMIC LINKER ld.so: rtld.c: 621: dl_main: Assertion 
 >`_dl_rtld_map.l_libname` failed!
 >Kernel panic: Attempted to kill init!
 >
 >This is a different message than I was getting in 2.4.18
 >but happens at the same time in bootup.
 >
 >The thing is, when I boot the original 2.4.5 it works fine.

Are you sure you did get exactly the same drivers and file system 
modules included as with your original 2.4.5 kernel? The reason I ask is 
that I've just spent two entire days trying (and finally suceeding) to 
get 2.4.18 working on a Compaq DL380 server (and no, not evern Red Hat's 
"original" kernels worked with these systems starting with 2.4.9-21).

I didn't get the same results as you did, but various other kinds of 
kernel panics either when it tried to mount the root file system or 
setting up swap. I'm not sure exactly how I did manage to get it to 
work, but I believe I finally figured that I needed to compile the 
cpqarray driver as a module and not as a static driver, and various 
other drivers static, especially those pertaining to file systems and 
such. Mkinitrd didn't pick them up correctly, and using --preload or 
--with to mkinitrd didn't help either. IOW, I fixed the problem with my 
systems by T&E. I know too little about your system to tell whether the 
problem is the same, or even similar.

/Robert

