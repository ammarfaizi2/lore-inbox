Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262404AbTCMP0W>; Thu, 13 Mar 2003 10:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262406AbTCMP0W>; Thu, 13 Mar 2003 10:26:22 -0500
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:23704 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id <S262404AbTCMP0W>; Thu, 13 Mar 2003 10:26:22 -0500
Date: Thu, 13 Mar 2003 16:36:53 +0100
From: Joern Engel <joern@wohnheim.fh-wedel.de>
To: Dave Jones <davej@codemonkey.org.uk>,
       Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: mb800 watchdog driver
Message-ID: <20030313153653.GA21104@wohnheim.fh-wedel.de>
References: <1047543064.16975.23.camel@gregs> <20030313161033.GA8751@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030313161033.GA8751@suse.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 March 2003 15:10:33 -0100, Dave Jones wrote:
> 
> in fact, these printk's should probably be something like dprintk's
> with dprintk being defined at the top of source like..
> 
> #define DEBUG
> #ifndef DEBUG
> # define dprintk(format, args...)
> #else
> # define dprintk(format, args...) printk(KERN_DEBUG "mb8wdog:", ## args)
                                                               ^^
> #endif

You might want to put an additional whitespace at the indicated
position, that works around a gcc 2.x bug.

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens
