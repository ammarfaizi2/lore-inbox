Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262085AbUJBLcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbUJBLcl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Oct 2004 07:32:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262329AbUJBLck
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Oct 2004 07:32:40 -0400
Received: from pop.gmx.net ([213.165.64.20]:54674 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262085AbUJBLci (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Oct 2004 07:32:38 -0400
X-Authenticated: #4399952
Date: Sat, 2 Oct 2004 13:47:32 +0200
From: Florian Schmidt <mista.tapas@gmx.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [Alsa-devel] alsa-driver will not compile with kernel
 2.6.9-rc2-mm4-S7
Message-ID: <20041002134732.7c38d39e@mango.fruits.de>
In-Reply-To: <1096675930.27818.74.camel@krustophenia.net>
References: <1096675930.27818.74.camel@krustophenia.net>
X-Mailer: Sylpheed-Claws 0.9.12a (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 01 Oct 2004 20:12:10 -0400
Lee Revell <rlrevell@joe-job.com> wrote:

> At first I thought my build was incorrect, but I reproduced this error
> with a clean build and ALSA CVS from today:
> 
>   CC [M] 
>   /home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore/pcm_native.o
> /home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3202:57: macro
> "io_remap_page_range" requires 5 arguments, but only 4
> given/home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c: In
> function
> `snd_pcm_lib_mmap_iomem':/home/rlrevell/cvs/alsa/alsa-driver/acore/pc
> m_native.c:3200: error: `io_remap_page_range' undeclared (first use in
> this
> function)/home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3200:
> error: (Each undeclared identifier is reported only
> once/home/rlrevell/cvs/alsa/alsa-driver/acore/pcm_native.c:3200:
> error: for each function it appears in.) make[3]: ***
> [/home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore/pcm_native.o]
> Error 1 make[2]: ***
> [/home/rlrevell/cvs/alsa/alsa-driver/kbuild/../acore] Error 2 make[1]:
> *** [_module_/home/rlrevell/cvs/alsa/alsa-driver/kbuild] Error 2
> make[1]: Leaving directory
> `/home/rlrevell/kernel-source/linux-2.6.9-rc2-mm4-S7' make: ***
> [compile] Error 2
> 
> I am not sure if this is an ALSA issue or -mm4.  I suspect -mm4
> because-mm3-S6 worked.  The VP patch does not seem to be involved.


Hmm, i have no problems compiling the alsa drivers included with the
kernel [yes, i'm on mm4-S7]..

tapas@mango:~$ gcc --version
gcc (GCC) 3.3.4 (Debian 1:3.3.4-13)

flo
