Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264779AbTAASQO>; Wed, 1 Jan 2003 13:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264790AbTAASQO>; Wed, 1 Jan 2003 13:16:14 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:56335 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S264779AbTAASQN>;
	Wed, 1 Jan 2003 13:16:13 -0500
Date: Wed, 1 Jan 2003 19:24:39 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Albert Kajakas <Albert.Kajakas@mail.ee>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 3rdparty modules for 2.5.53
Message-ID: <20030101182439.GA2293@mars.ravnborg.org>
Mail-Followup-To: Albert Kajakas <Albert.Kajakas@mail.ee>,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
References: <200301011719.h01HJOB21702@mail-fe2.tele2.ee>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301011719.h01HJOB21702@mail-fe2.tele2.ee>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 01, 2003 at 07:19:24PM +0200, Albert Kajakas wrote:
> 
> Hello!
> I have a problem with compiling modules for 2.5.
> i wrote a module for 2.4. For 2.5 (51,52,53) it compiles nicely, but insmod complains about invalid format. I have the latest module init tools of Rusty installed.  I'm usin gcc 3.2. Do i have to use any special compiler/linker options or defines or whatever to generate a working module ? what could be the problem ? Even a simple hello-world module doesnt work. Although, i have a working 2.5.53 modular kernel that was built using same tools.
> 

Try to folllow this reciept posted by Kai G.
-------------
Well, you can do

cd my_module
echo "obj-m := my_module.o" > Makefile
vi my_module.c
make -C <path/to/kernel/src> SUBDIRS=$PWD modules

That's not too bad (and basically works for 2.4 as well)
---------------

	Sam
