Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267090AbTBCWnS>; Mon, 3 Feb 2003 17:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267085AbTBCWnS>; Mon, 3 Feb 2003 17:43:18 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:60075 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S267090AbTBCWnO>; Mon, 3 Feb 2003 17:43:14 -0500
From: David Woodhouse <dwmw2@infradead.org>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030203153510.A21371@devserv.devel.redhat.com>
References: <1044285222.2396.14.camel@gregs>
	<1044285587.2527.4.camel@laptop.fenrus.com>
	<1044286557.2402.20.camel@gregs> 
	<20030203153510.A21371@devserv.devel.redhat.com>
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Feb 2003 22:52:39 +0000
Message-Id: <1044312759.28409.28.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Subject: Re: [BUG] vmalloc, kmalloc - 2.4.x
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 15:35, Arjan van de Ven wrote:
> On Mon, Feb 03, 2003 at 03:35:57PM +0000, Grzegorz Jaskiewicz wrote:
> > On Mon, 2003-02-03 at 15:19, Arjan van de Ven wrote:
> > > > #include <linux/modversions.h>
> > > don't do that. ever.
> > why ?
> 
> because if you ever need it, modules.h will automatically include
> it for you already. And if it doesn't you don't need it and it does more
> harm than good.

Is that true? I thought the kernel build system added it with the
-include argument to gcc? And so it works properly _only_ if you're
using the correct way of building out-of-tree modules, which as
discussed recently on this list is

	make -C $LINUXDIR SUBDIRS=`pwd`

where LINUXDIR defaults to /lib/modules/`uname -r`/build unless the user
specifies otherwise.

Some distributions ship a kernel-source package which is broken and does
not work like this. File that as a bug if you encounter it.

/me runs from Arjan :)

-- 
dwmw2

