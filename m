Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291372AbSCOLwO>; Fri, 15 Mar 2002 06:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291394AbSCOLwF>; Fri, 15 Mar 2002 06:52:05 -0500
Received: from ns.suse.de ([213.95.15.193]:10758 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291372AbSCOLvr>;
	Fri, 15 Mar 2002 06:51:47 -0500
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IO delay, port 0x80, and BIOS POST codes
In-Reply-To: <3C90E983.5AC769B8@ngforever.de.suse.lists.linux.kernel> <Pine.LNX.4.33.0203151243430.1477-100000@biker.pdb.fsc.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Mar 2002 12:51:44 +0100
In-Reply-To: Martin Wilck's message of "15 Mar 2002 12:46:28 +0100"
Message-ID: <p73lmcuyrov.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Wilck <Martin.Wilck@fujitsu-siemens.com> writes:

> On Thu, 14 Mar 2002, Thunder from the hill wrote:
> 
> > I also remember this been discussed anually. Making it configurable with
> > a warning might be a solution, but that's nothing we could decide. Maybe
> > add a config option? It night be a [DANGEROUS] one, so the guys and gals
> > who might compile are warned of changing this.
> 
> It doesn't even have to be a config option - a line
> 
> /* Port used for dummy writes for I/O delays */
> /* Change this only if you know what you're doing ! */
> #define DUMMY_IO_PORT 0x80
> 
> in a header file would perfectly suffice.

That effectively already exists. You just need to change the __SLOW_DOWN_IO
macro in include/asm-i387/io.h

-Andi
