Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbTBHBir>; Fri, 7 Feb 2003 20:38:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266953AbTBHBir>; Fri, 7 Feb 2003 20:38:47 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:2176 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S266948AbTBHBiq>; Fri, 7 Feb 2003 20:38:46 -0500
Date: Fri, 7 Feb 2003 19:48:36 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: possible partition corruption
In-Reply-To: <20030207154045.5080b1b0.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0302071943500.844-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 7 Feb 2003, Andrew Morton wrote:

> I couldn't immediately see the reason for this.  You have your whole input
> layer configured as a module, perhaps that has upset things.
> 
> I suggest that you work on the config settings and find out what it is that
> is causing the tty layer to not come up.

OK, Hold the phone Susan, and stamp IDIOT on my forehead.  The erason for 
not getting any output on the console was that I had configured the kernel 
without support for virtual terminals or console on virtual terminals.  
Once I configured that correctly, things worked. Duh!

The thing I don't understand is why would not having that configured in 
give me the lost journal and an inability to boot and mount the root 
partition when I booted back into a "normal" kernel.

