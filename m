Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317022AbSFWNZZ>; Sun, 23 Jun 2002 09:25:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317023AbSFWNZZ>; Sun, 23 Jun 2002 09:25:25 -0400
Received: from twilight.cs.hut.fi ([130.233.40.5]:31404 "EHLO
	twilight.cs.hut.fi") by vger.kernel.org with ESMTP
	id <S317022AbSFWNZY>; Sun, 23 Jun 2002 09:25:24 -0400
Date: Sun, 23 Jun 2002 16:25:14 +0300
From: Ville Herva <vherva@niksula.hut.fi>
To: clock@atrey.karlin.mff.cuni.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmalloc size too large
Message-ID: <20020623132513.GF1548@niksula.cs.hut.fi>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	clock@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
References: <20020623104012.B532@ghost.cybernet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020623104012.B532@ghost.cybernet.cz>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 23, 2002 at 10:40:12AM +0200, you [clock@atrey.karlin.mff.cuni.cz] wrote:
> 
> Jun 23 10:34:18 ghost kernel: kmalloc: Size (4294852048) too large

Come to think of it, adding mere

        printk ("Current PID: %i\n", current->pid);
        printk ("called from %p\n", __builtin_return_address(0));

after

        printk(KERN_ERR "kmalloc: Size (%lu) too large\n", (unsigned long) size);

in mm/slab.c:kmalloc() might be enough.



-- v --

v@iki.fi
