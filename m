Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264447AbTDPR34 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 13:29:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264465AbTDPR34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 13:29:56 -0400
Received: from coral.ocn.ne.jp ([211.6.83.180]:64709 "HELO
	smtp.coral.ocn.ne.jp") by vger.kernel.org with SMTP id S264447AbTDPR3z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 13:29:55 -0400
Date: Thu, 17 Apr 2003 02:41:47 +0900
From: Bruce Harada <bharada@coral.ocn.ne.jp>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: System Call parameters
Message-Id: <20030417024147.33a76987.bharada@coral.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.53.0304161256130.11667@chaos>
References: <Pine.LNX.4.53.0304161256130.11667@chaos>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Apr 2003 12:58:15 -0400 (EDT)
"Richard B. Johnson" <root@chaos.analogic.com> wrote:

> 
> How does the kernel get more than five parameters?
> 
> Currently...
> 	eax	= function code
> 	ebx	= first parameter
> 	ecx	= second parameter
> 	edx	= third parameter
> 	esi	= fourth parameter
> 	edi	= fifth parameter
> 
> Some functions like mmap() take 6 parameters!
> Does anybody know how these parameters get passed?
> I have an "ultra-light" 'C' runtime library I have
> been working on and, so-far, I've got everything up
> to mmap()  (in syscall.h) (89 functions) working.
> I thought, maybe ebp was being used, but it doesn't
> seem to be the case.
> 
> Maybe after 5 functions, there is a parameter list
> passed by pointer???? I don't have a clue and I
> can figure out the code, it's really obscure...

>From http://www.google.co.jp/search?q=cache:7GJP4whNQEkC:webster.cs.ucr.edu/Page_Linux/LinuxSysCalls.pdf+Linux+mmap+parameters+ebp&hl=ja&ie=UTF-8 :

 Certain Linux 2.4 calls pass a sixth parameter in EBP. Calls compatible with earlier versions of the kernel pass six or
 more parameters in a parameter block and pass the address of the parameter block in EBX (this change was probably
 made in kernel 2.4 because someone noticed that an extra copy between kernel and user space was slowing down
 those functions with exactly six parameters; who knows the real reason, though).

Relevant? No idea.

