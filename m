Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264954AbSK0Xru>; Wed, 27 Nov 2002 18:47:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264950AbSK0Xrt>; Wed, 27 Nov 2002 18:47:49 -0500
Received: from dp.samba.org ([66.70.73.150]:35712 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S264946AbSK0Xrs>;
	Wed, 27 Nov 2002 18:47:48 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org, vandrove@vc.cvut.cz, zippel@linux-m68k.org
Subject: Re: Modules with list 
In-reply-to: Your message of "Tue, 26 Nov 2002 23:22:34 -0800."
             <200211270722.XAA23313@adam.yggdrasil.com> 
Date: Thu, 28 Nov 2002 10:15:57 +1100
Message-Id: <20021127235506.5744F2C075@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200211270722.XAA23313@adam.yggdrasil.com> you write:
> Rusty Russell wrote:
> >In message <200211260649.WAA22216@adam.yggdrasil.com> you write:
> >> >This would only happen if someone says "rmmod --wait".
> 
> >As I realized last night after I wrote this, there is a bug in
> >module.c.  If O_NONBLOCK is specified, we shouldn't drop the module
> >sempaphore at all, for exactly this reason.  A bug I introduced while
> >"cleaning up" the "--wait" path.
> 
> >Sorry for the confusion.
> 
> 	Then if you do "rmmod --wait" on some module that is in use,
> every lsmod, insmod and rmmod will hang while attempting to acquire

Sorry, that's why I said "*If O_NONBLOCK* is specified" (ie. still
drop it for the --wait case).

Hope that clarifies,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
