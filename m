Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265063AbTANTAv>; Tue, 14 Jan 2003 14:00:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265074AbTANTAv>; Tue, 14 Jan 2003 14:00:51 -0500
Received: from chaos.analogic.com ([204.178.40.224]:53382 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265063AbTANTAu>; Tue, 14 Jan 2003 14:00:50 -0500
Date: Tue, 14 Jan 2003 14:10:23 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: DervishD <raul@pleyades.net>
cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
In-Reply-To: <20030114185934.GA49@DervishD>
Message-ID: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Jan 2003, DervishD wrote:

>     Hi all :))
> 
>     I'm not sure whether this issue belongs to the kernel or to the
> libc, but I think that is more on the kernel side, that's why I ask
> here.
> 

Last time I checked argv[0] was 512 bytes. Many daemons overwrite
it with no problem.

  PID TTY STAT  TIME COMMAND
  126   4 S    0:00 /sbin/agetty 38400 tty4 
  127   5 S    0:00 /sbin/agetty 38400 tty5 
  128   6 S    0:00 /sbin/agetty 38400 tty6 
 5241   2 S    0:00 -bash 
13476   1 S    0:00 How-long-do-you-want-this-string-to-be?--is-this-long-enoug
13489   3 R    0:00 ps 
27498   3 S    0:00 -bash 
31011   1 S    0:00 -bash  

#include <stdio.h>
#include <string.h>
int main(int cnt, char *argv[]) {
    strcpy(argv[0], "How-long-do-you-want-this-string-to-be?--is-this-long-enough?");
    pause();
    return 0;
}

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


