Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269810AbRHMFUu>; Mon, 13 Aug 2001 01:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269815AbRHMFUk>; Mon, 13 Aug 2001 01:20:40 -0400
Received: from zok.SGI.COM ([204.94.215.101]:31969 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S269811AbRHMFUf>;
	Mon, 13 Aug 2001 01:20:35 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "SATHISH.J" <sathish.j@tatainfotech.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Reg System.map file 
In-Reply-To: Your message of "Mon, 13 Aug 2001 10:52:42 +0530."
             <Pine.LNX.4.10.10108131048560.31544-100000@blrmail> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 13 Aug 2001 15:16:35 +1000
Message-ID: <10876.997679795@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Aug 2001 10:52:42 +0530 (IST), 
"SATHISH.J" <sathish.j@tatainfotech.com> wrote:
>Does the System.map file contain only the addresses of kernel functions
>present at the boot time. What I mean is, suppose I insert a new driver
>into the kernel, Is there any way to show its addresses in the System.map
>file? Please help me out with this.

System.map contains addresses of all the external symbols in vmlinux.
It does not contain the address of module symbols because they vary.
If you want a combined map that contains both kernel and module
symbols, use ksymoops -s.  That works best when you save the module
data after each module load and unload.

  man ksymoops
  man insmod, section KSYMOOPS SUPPORT IN MODUTILS.

