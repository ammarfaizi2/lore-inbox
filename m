Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262067AbSJDPcC>; Fri, 4 Oct 2002 11:32:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262061AbSJDPa7>; Fri, 4 Oct 2002 11:30:59 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:46324 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S262057AbSJDPaL>; Fri, 4 Oct 2002 11:30:11 -0400
Date: Fri, 4 Oct 2002 17:35:39 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: sander79@wanadoo.nl
cc: linux-kernel@vger.kernel.org
Subject: Re: bug report
In-Reply-To: <200210041701.21475.sander@kamphuis.dyndns.org>
Message-ID: <Pine.NEB.4.44.0210041733550.11119-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Oct 2002, Sander Kamphuis wrote:

> *This message was transferred with a trial version of CommuniGate(tm) Pro*
> error after compiling kernel 2.4.20pre8 after applying the patch pre7 -> pre8
> the following error occures after running 'make bzImage'
>
> (translated from dutch)
> make[2]: Leave map `/usr/src/linux/fs/nls'
> make -C partitions
> make[2]: Enter map `/usr/src/linux/fs/partitions'
> make all_targets
> make[3]: Enter map `/usr/src/linux/fs/partitions'
> make[3]: *** No line for farget `/usr/src/linux/include/asm-ia64/efi.h',
> nessery for `efi.h'. Stop.
>...

You forgot to do a

  make mrproper

before starting the

  cp /path/to/.config .
  make oldconfig dep bzImage


cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox

