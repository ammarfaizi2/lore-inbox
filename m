Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261784AbSJMWqd>; Sun, 13 Oct 2002 18:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261785AbSJMWqd>; Sun, 13 Oct 2002 18:46:33 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:37622 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S261784AbSJMWqc>;
	Sun, 13 Oct 2002 18:46:32 -0400
Date: Mon, 14 Oct 2002 00:52:22 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Message-ID: <20021013225222.GA23518@win.tue.nl>
References: <200210131924.MAA00308@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200210131924.MAA00308@baldur.yggdrasil.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 12:24:26PM -0700, Adam J. Richter wrote:

> 	linux-2.5.42 had an annoying new behavior.  When I would
> try to do a warm reboot, it would spin down the hard drives, which
> just made the reboot take longer and gave the impression that a
> halt or poweroff was in progress.

Yes. In my case worse than annoying:
The drives spin down, but have not yet completed spindown when
the machine is started again. LILO fails (prints a single 's'
where I would have expected "uncompressing kernel" and dies).
Pressing reset results in a strange garbled BIOS screen, and a hang.
After a power cycle all is well again.

So, my hardware is very unhappy with the new 2.5.42 behaviour.

Andries


[2.5.33 works for me, but no later kernel does.]
