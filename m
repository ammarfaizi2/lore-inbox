Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267574AbSLSGr5>; Thu, 19 Dec 2002 01:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267575AbSLSGr5>; Thu, 19 Dec 2002 01:47:57 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:3511 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267574AbSLSGr4>;
	Thu, 19 Dec 2002 01:47:56 -0500
Date: Thu, 19 Dec 2002 12:41:00 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Zwane Mwaikambo <zwane@holomorphy.com>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] module-init-tools 0.9.3, rmmod modules with '-'
Message-ID: <20021219124100.A3850@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <20021218022816.913AC2C238@lists.samba.org> <Pine.LNX.4.44.0212181144120.21707-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0212181144120.21707-100000@chaos.physics.uiowa.edu>; from kai-germaschewski@uiowa.edu on Wed, Dec 18, 2002 at 11:47:26AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 18, 2002 at 11:47:26AM -0600, Kai Germaschewski wrote:
> On Wed, 18 Dec 2002, Rusty Russell wrote:
> 
> > In message <20021217114846.A30837@in.ibm.com> you write:
> > > On Tue, Dec 17, 2002 at 11:17:05AM +1100, Rusty Russell wrote:
> > > > 
> > > > BTW, this was done for (1) simplicity, (2) so KBUILD_MODNAME can be
> > > > used to construct identifiers, and (3) so parameters when the module
> > > > is built-in have a consistent name.
> > > > 
> > > Ok, I see it now, this magic happens in scripts/Makefile.lib. 
> > > My module has been built outside the kernel build system, that's
> > > why I saw this problem.
> > > 
> > > I guess avoiding '-' should do it, but is there a simple way to 
> > > correctly build (simple, test) modules outside the kernel tree now?
> > 
> > Has there ever been a simple way?
> 
> Well, you can do
> 
> cd my_module
> echo "obj-m := my_module.o" > Makefile
> vi my_module.c
> make -C <path/to/kernel/src> SUBDIRS=$PWD modules
> 
> That's not too bad (and basically works for 2.4 as well)
> 
That's way cool! Thank you.

-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
