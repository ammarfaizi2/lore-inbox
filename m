Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266080AbTLIUTw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 15:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266111AbTLIUSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 15:18:17 -0500
Received: from zeus.kernel.org ([204.152.189.113]:37280 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S266110AbTLIUPh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 15:15:37 -0500
Date: Tue, 9 Dec 2003 12:10:47 -0500
From: Mark Mielke <mark@mark.mielke.cc>
To: Holger Schurig <h.schurig@mn-logistik.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of devfs in 2.6?
Message-ID: <20031209171047.GA29799@mark.mielke.cc>
References: <200312081536.26022.andrew@walrond.org> <20031208154256.GV19856@holomorphy.com> <pan.2003.12.08.23.04.07.111640@dungeon.inka.de> <20031208233428.GA31370@kroah.com> <1070953338.7668.6.camel@simulacron> <20031209071303.GB24876@Master.launchmodem.com> <br41h9$mth$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <br41h9$mth$1@sea.gmane.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 09, 2003 at 09:21:56AM +0100, Holger Schurig wrote:
> Devfs for embedded devices is just great. It's all in the kernel, no
> external process to run (I use my embedded stuff without devfsd). I'm using
> it for about one year with various kernels.

I don't see why 'all in the kernel' is the best approach, embedded or
otherwise. I believe udev is being written to execute with a minimal
runtime environment. No glibc, or other such beasts.

> * space. devfs doesn't eat space like the MAKEDEV approach.

Can you prove this? tmpfs doesn't seem to take up much space, and given
that only devices that exist will require data structures in both cases,
it seems to me that the issue is a little irrelevant in either case.

> * simplicity: I run my system without devfsd and without an initial ramdisk.
> All needed modules are simply compiled into the kernel.

Isn't this an argument for udev?

> * No need for overcomplification, e.g a process that has to be started
> before userspace touches /dev, a specially compiled uclibc-based proggy in
> an initrd

Many of us believe that devfs is 'over-complification'.

> So, when /dev is accessed by userspace, all is there and well.

True in either case...

mark

-- 
mark@mielke.cc/markm@ncf.ca/markm@nortelnetworks.com __________________________
.  .  _  ._  . .   .__    .  . ._. .__ .   . . .__  | Neighbourhood Coder
|\/| |_| |_| |/    |_     |\/|  |  |_  |   |/  |_   | 
|  | | | | \ | \   |__ .  |  | .|. |__ |__ | \ |__  | Ottawa, Ontario, Canada

  One ring to rule them all, one ring to find them, one ring to bring them all
                       and in the darkness bind them...

                           http://mark.mielke.cc/

