Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129292AbRCPAmg>; Thu, 15 Mar 2001 19:42:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129381AbRCPAm0>; Thu, 15 Mar 2001 19:42:26 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:55563 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S129292AbRCPAmG>; Thu, 15 Mar 2001 19:42:06 -0500
Date: Thu, 15 Mar 2001 19:56:57 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "Shane Y. Gibson" <sgibson@digitalimpact.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops 0000 and 0002 on dual PIII 750 2.4.2 SMP platform
In-Reply-To: <3AB13120.AE7187B@digitalimpact.com>
Message-ID: <Pine.LNX.4.21.0103151954260.4383-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 15 Mar 2001, Shane Y. Gibson wrote:

> 
> All,
> 
> I just compiled 2.4.2 and installed it on a otherwise stock
> Redhat 7.0 platform.  The system is a SuperMicro PIIISME, 
> running dual PIII 750s, with 256 cache.  It appears that about
> every 10 to 18 hours, the system is panicing, and freezing
> up.  The first time, I got an oops 0000, the second time an
> oops 0002.  Both crashes have occured only when the systems is
> at 100% cpu utlization; processing several hundred MRTG 
> indexmaker operations.
> 
> I ran ksymoops on both outputs, and the results are pasted
> below.  Note, I compiled the kernel without loadable module
> support.  Please let me know if there is anything else I can
> do/provide to help.  Unfortunately, the second didn't output
> enough for ksymoops to extract anything usefull.
> 
> v/r
> Shane
> 
> ------------------- first ksymoops output ------------------- 
> 
> ksymoops 2.3.4 on i686 2.4.2.  Options used
>      -V (default)
>      -K (specified)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.2/ (default)
>      -m /boot/System.map (specified)
> 
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> Mar 14 22:05:12 walker kernel: invalid operand: 0000
> Mar 14 22:05:12 walker kernel: CPU:    0

Hi Shane, 

Did'nt you get a message similar to 

"kernel BUG at page_alloc.c line xxx!"

Before the first oops ? 

It looks like this oops was triggered by a "BUG()" call, and in this case
this message should be printed before the oops.

Thanks 

