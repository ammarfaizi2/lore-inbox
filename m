Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbSJQMGI>; Thu, 17 Oct 2002 08:06:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261520AbSJQMFc>; Thu, 17 Oct 2002 08:05:32 -0400
Received: from ns.suse.de ([213.95.15.193]:37132 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261514AbSJQMEH>;
	Thu, 17 Oct 2002 08:04:07 -0400
Date: Thu, 17 Oct 2002 14:10:05 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Srihari Vijayaraghavan <harisri@bigpond.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20pre11aa1
Message-ID: <20021017141005.A8863@oldwotan.suse.de>
References: <20021016165155.GE30254@dualathlon.random> <200210172204.50297.harisri@bigpond.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200210172204.50297.harisri@bigpond.com>; from harisri@bigpond.com on Thu, Oct 17, 2002 at 10:04:50PM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2002 at 10:04:50PM +1000, Srihari Vijayaraghavan wrote:
> Hello Andrea,
> 
> > Srihari, I would like if you could try to reproduce with this new one
> > with CONFIG_SOUND=n.  Thanks!
> 
> No worries!
> 
> I tried it without sound and unfortunately it crashed few times. The good news 
> is that it is very stable without agpgart and radeon (module or not) support.

I've no idea what could be wrong with the graphics drivers, there are no
changes there. 

> ffffffff   esp: c58f5f78
> Oct 17 20:27:24 localhost kernel: ds: 0018   es: 0018   ss: 0018
> Oct 17 20:27:24 localhost kernel: Process modprobe (pid: 888, 


please try to find which is this module, replace modprobe with a script
that does:

#!/bin/sh
echo $@ >>/tmp/log
sync
modprobe.orig $@

then look at log after the crash. You said in your last email that the
gart code wasn't the culprit. If it isn't the sound drivers I've no
clue what it is. What does it mean the without agpgart it is very
stable? That it crashes less frequently? (I recalled it crashed even
without those modules)

It doesn't make any sense that 2.4.20-pre11 works and my tree doesn't,
there are no changes to those sound and graphics driver. Can you make
sure that modversions is enabled, and please send me your .config.

Andrea
