Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbSJTUiB>; Sun, 20 Oct 2002 16:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264645AbSJTUiB>; Sun, 20 Oct 2002 16:38:01 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:8197 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264644AbSJTUiA>;
	Sun, 20 Oct 2002 16:38:00 -0400
Date: Sun, 20 Oct 2002 22:43:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Murali Therthala <MuraliT@prodigy.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compilation Error with a Dynamic Module
Message-ID: <20021020224358.A13954@mars.ravnborg.org>
Mail-Followup-To: Murali Therthala <MuraliT@prodigy.net>,
	linux-kernel@vger.kernel.org
References: <001301c2786e$1303b160$eef13ccc@kamalnara317>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <001301c2786e$1303b160$eef13ccc@kamalnara317>; from MuraliT@prodigy.net on Sun, Oct 20, 2002 at 03:22:46PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 20, 2002 at 03:22:46PM -0400, Murali Therthala wrote:
> Hi All,
> 
> I am trying to compile a dynamic module shown below that creates a readable
> procs entry.
> I invoke gcc as follows.
> 
> gcc -Wall -o2 -DMODULE -D_KERNEL_ -DLINUX -I
> /lib/modules/`uname -r`\build/modules -c fMod3.c

The easiet way is to add
obj-m	+= myprocfsexample.o
to for example fs/Makefile

Then you can see what arguments are used for gcc in the real kernel compile.
I tried compiling your file in this way - no problem.

	Sam
