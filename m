Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266959AbTBHB5E>; Fri, 7 Feb 2003 20:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266958AbTBHB5E>; Fri, 7 Feb 2003 20:57:04 -0500
Received: from packet.digeo.com ([12.110.80.53]:41114 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266959AbTBHB5C>;
	Fri, 7 Feb 2003 20:57:02 -0500
Date: Fri, 7 Feb 2003 18:06:39 -0800
From: Andrew Morton <akpm@digeo.com>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: possible partition corruption
Message-Id: <20030207180639.046eb256.akpm@digeo.com>
In-Reply-To: <Pine.LNX.4.44.0302071943500.844-100000@localhost.localdomain>
References: <20030207154045.5080b1b0.akpm@digeo.com>
	<Pine.LNX.4.44.0302071943500.844-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Feb 2003 02:06:37.0192 (UTC) FILETIME=[B6254080:01C2CF16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Molina <tmolina@cox.net> wrote:
>
> On Fri, 7 Feb 2003, Andrew Morton wrote:
> 
> > I couldn't immediately see the reason for this.  You have your whole input
> > layer configured as a module, perhaps that has upset things.
> > 
> > I suggest that you work on the config settings and find out what it is that
> > is causing the tty layer to not come up.
> 
> OK, Hold the phone Susan, and stamp IDIOT on my forehead.  The erason for 
> not getting any output on the console was that I had configured the kernel 
> without support for virtual terminals or console on virtual terminals.  
> Once I configured that correctly, things worked. Duh!

Yes, but you had CONFIG_VGA_CONSOLE=y.

> The thing I don't understand is why would not having that configured in 
> give me the lost journal and an inability to boot and mount the root 
> partition when I booted back into a "normal" kernel.

Don't know.  It didn't do that when I tested it.
