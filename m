Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262007AbSJNRus>; Mon, 14 Oct 2002 13:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262065AbSJNRur>; Mon, 14 Oct 2002 13:50:47 -0400
Received: from mail18.svr.pol.co.uk ([195.92.67.23]:10501 "EHLO
	mail18.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S262062AbSJNRup>; Mon, 14 Oct 2002 13:50:45 -0400
Date: Mon, 14 Oct 2002 18:56:08 +0100
To: Austin Gonyou <austin@coremetrics.com>
Cc: linux-lvm@sistina.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [linux-lvm] Re: [PATCH] 2.5 version of device mapper submission
Message-ID: <20021014175608.GA14963@fib011235813.fsnet.co.uk>
References: <1034453946.15067.22.camel@irongate.swansea.linux.org.uk> <1034614756.29775.5.camel@UberGeek.coremetrics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1034614756.29775.5.camel@UberGeek.coremetrics.com>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 11:59:17AM -0500, Austin Gonyou wrote:
> Just curious, but device-mapper and 2.5.42 do not seem to jive very
> well. Please advise.

Try the patches at:

http://people.sistina.com/~thornber/patches/2.5-unstable/

There are three minor changes:

09.patch
  [Device-mapper]
  Remove linux/iobuf.h include.

10.patch
  [Device-mapper]
  Add call to blk_queue_bounce() at the beginning of the request function.

11.patch
  [Device-mapper]
  Pass md into dm_suspend/dm_resume instead of a kdev_t.

- Joe
