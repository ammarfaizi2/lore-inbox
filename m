Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313416AbSFLUGY>; Wed, 12 Jun 2002 16:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313563AbSFLUGY>; Wed, 12 Jun 2002 16:06:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10515 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313416AbSFLUGW>; Wed, 12 Jun 2002 16:06:22 -0400
Date: Wed, 12 Jun 2002 13:04:09 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Benjamin LaHaise <bcrl@redhat.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.20 x86 iobitmap cleanup
In-Reply-To: <20020606011546.A10030@redhat.com>
Message-ID: <Pine.LNX.4.33.0206121300330.1533-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 6 Jun 2002, Benjamin LaHaise wrote:
> 
> Below is a patch against base 2.5.20 which makes the io port 
> bitmap in thread_struct a pointer to a bitmap that is only 
> allocated when the process calls ioperm.  This results in 132 
> bytes being removed from struct task_struct.

Why do you introduce a arch_dispose_thread_struct(), instead of just 
making the x86 exit_thread() do it?

		Linus

