Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314600AbSDTKAk>; Sat, 20 Apr 2002 06:00:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314601AbSDTKAj>; Sat, 20 Apr 2002 06:00:39 -0400
Received: from pop.gmx.de ([213.165.64.20]:27508 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S314600AbSDTKAi>;
	Sat, 20 Apr 2002 06:00:38 -0400
Subject: Re: idea to enhance get_pid()
From: Dan Aloni <da-x@gmx.net>
To: lenny lv <lennylv@hotmail.com>
Cc: linux-kernel@vger.kernel.org, qiang@suda.edu.cn
In-Reply-To: <F74PKipeUekcMrvgldU00000fc8@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 20 Apr 2002 12:59:27 +0300
Message-Id: <1019296776.24728.40.camel@callisto.yi.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-04-20 at 12:15, lenny lv wrote:

> I've got an idea to speed up linux/kernel/fork.c/get_pid(). Why not use 
> bitmap to alloc/free the pids? Is it because 4KB(32K/8) memory scanning is 
> slower than the current get_pid() version? Does anyone benchmark them?

This could have been a good idea if Linux was to stay with 15-bit pids
forever. The code you are suggesting will have to be rewritten sometime
to support 32 bit pids. 

The last time I checked, the only thing that stops the move back to
32-bit pids is a bug in the bash shell, and just a few workable IPC
interfaces and libc breakages.

Are 32 bit pids planned for 2.5?

