Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265267AbSJRVrH>; Fri, 18 Oct 2002 17:47:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265375AbSJRVrH>; Fri, 18 Oct 2002 17:47:07 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:13227 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S265267AbSJRVrC>; Fri, 18 Oct 2002 17:47:02 -0400
Date: Fri, 18 Oct 2002 16:52:52 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Rusty Russell <rusty@rustcorp.com.au>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Module loader preparation 
In-Reply-To: <20021018025632.009BE2C0BB@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0210181650340.10010-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Oct 2002, Rusty Russell wrote:

> > Did you consider just generating the info you need unconditionally in 
> > include/linux/module.h and then removing duplicates for multi-part modules 
> > using ld's link-once (I didn't try that yet, but it seems doable and would 
> > also remove duplicated .modinfo.kernel_version strings and the like)
> 
> Didn't think of it, to be honest, and I can't find any reference to
> link-once glancing through the ld info page.
> 
> You'll still have problems with objects linked into two modules
> (ip_conntrack_core being the typical one), but we could ban these and
> just #include the .c file rather than linking.

Right, they'd be a problem (I'm not sure if having this kind of code
sharing is a good idea, generally, but that's another issue).

> Really, the number of modules which do this is so small, the code to
> add init function to them is less than the change in the build system
> to get tricky.

I tend to agree, in particular taking into account the problem you 
mentioned above...

--Kai



