Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262324AbSJENGc>; Sat, 5 Oct 2002 09:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262325AbSJENGc>; Sat, 5 Oct 2002 09:06:32 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:40443 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262324AbSJENGb>; Sat, 5 Oct 2002 09:06:31 -0400
Subject: Re: Why does x86_64 support a SuSE-specific ioctl?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Andi Kleen <ak@suse.de>
Cc: Adrian Bunk <bunk@fs.tum.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
In-Reply-To: <p73adltqz9g.fsf@oldwotan.suse.de>
References: <Pine.NEB.4.44.0210041654570.11119-100000@mimas.fachschaften.tu-muenchen.de.
	 suse.lists.linux.kernel>  <p73adltqz9g.fsf@oldwotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 05 Oct 2002 14:20:43 +0100
Message-Id: <1033824043.3425.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-10-05 at 05:35, Andi Kleen wrote:
>  		 */
> diff -urN linux-2.4.18.tmp/include/asm-alpha/ioctls.h linux-2.4.18.SuSE/include/asm-alpha/ioctls.h
> --- linux-2.4.18.tmp/include/asm-alpha/ioctls.h	Sat May  4 11:37:28 2002
> +++ linux-2.4.18.SuSE/include/asm-alpha/ioctls.h	Sat May  4 11:37:56 2002
> @@ -92,6 +92,7 @@
>  #define TIOCGSID	0x5429  /* Return the session ID of FD */
>  #define TIOCGPTN	_IOR('T',0x30, unsigned int) /* Get Pty Number (of pty-mux device) */
>  #define TIOCSPTLCK	_IOW('T',0x31, int)  /* Lock/unlock Pty */
> +#define TIOCGDEV	_IOR('T',0x32, unsigned int) /* Get real dev no below /dev/console */
>  

Shouldn't these values be reserved in 2.5 before anything goes into 2.4
for this - the values finally used might be different

