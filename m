Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290223AbSAXAQS>; Wed, 23 Jan 2002 19:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290224AbSAXAQI>; Wed, 23 Jan 2002 19:16:08 -0500
Received: from splat.lanl.gov ([128.165.17.254]:45531 "EHLO
	balance.radtt.lanl.gov") by vger.kernel.org with ESMTP
	id <S290223AbSAXAPz>; Wed, 23 Jan 2002 19:15:55 -0500
Date: Wed, 23 Jan 2002 17:15:52 -0700
From: Eric Weigle <ehw@lanl.gov>
To: "Punj, Arun" <Arun.Punj@marconi.com>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: NEWBIE : can't find /lib/modules/2.4.17/modules.dep error
Message-ID: <20020124001552.GC12041@lanl.gov>
In-Reply-To: <313680C9A886D511A06000204840E1CF40B60A@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <313680C9A886D511A06000204840E1CF40B60A@whq-msgusr-02.pit.comms.marconi.com>
User-Agent: Mutt/1.3.25i
X-Eric-Unconspiracy: There ought to be a conspiracy
X-Editor: Vim, http://www.vim.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I upgraded the 2.4.7-10 kernel that comes with RH7.2 to 2.4.17. 
> [ I could compile it fine and grub is able to load it too...]
> 
> However, I see the error : can't find /lib/modules/2.4.17/modules.dep
> multiple times.
Sounds like you didn't make or install modules. Most kernels these days
are best built using modules for device drivers and such that are loaded
on-demand during runtime, instead of being part of a big 'monolithic'
kernel. This saves space in memory and has some other benefits (although
this is open to debate).

`make bzImage` makes just the 'monolithic' part of the kernel, while `make
modules` and `make modules_install` handle building and installing modules,
and should create the proper directories and put in the appropriate files.

If you did execute the modules commands (as root, of course), the problem
might be in your module loader program suite (insmod, lsmod, etc.). Old
versions of the program don't work with newer kernels. I'm not a RedHat user
so I wouldn't know about that, but you could check their site and download
the latest RPM if that seems to be the problem.

-Eric

-- 
--------------------------------------------
 Eric H. Weigle   CCS-1, RADIANT team
 ehw@lanl.gov     Los Alamos National Lab
 (505) 665-4937   http://home.lanl.gov/ehw/
--------------------------------------------
