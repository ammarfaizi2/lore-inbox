Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318338AbSG3PF1>; Tue, 30 Jul 2002 11:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318339AbSG3PF1>; Tue, 30 Jul 2002 11:05:27 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31250 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318338AbSG3PF0>; Tue, 30 Jul 2002 11:05:26 -0400
Date: Tue, 30 Jul 2002 16:08:45 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Kai Engert <kai.engert@gmx.de>
Cc: James Mayer <james@cobaltmountain.com>, linux-kernel@vger.kernel.org,
       Ani Joshi <ajoshi@unixbox.com>
Subject: Re: Sync bit bug in drivers/video/radeonfb.c ?
Message-ID: <20020730160845.B7677@flint.arm.linux.org.uk>
References: <3D4689E5.5000504@gmx.de> <20020730143309.GA21219@galileo> <3D46A8A0.2020101@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D46A8A0.2020101@gmx.de>; from kai.engert@gmx.de on Tue, Jul 30, 2002 at 04:54:24PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 30, 2002 at 04:54:24PM +0200, Kai Engert wrote:
> That's strange! I'm using a C1MGP, german version.
> 
> See http://www.kuix.de/sonyc1/lspci for lspci output.
> 
> However, if you apply the patch below, and you have to manually set it 
> to vsync low, I guess this means your on boot mode was set to high, 
> which is what is requested in modedb.c, and it sounds like the patch 
> below is correct. But we probably need more entries in modedb.c to 
> support all models of the C1M.

Maybe the real answer is for someone to scope the sync signals and
work out whether the original or the patched version is correct.
Then someone's left with a buggy monitor (which, quote honestly
wouldn't surprise me in the least.)

If a buggy monitor is the problem, it might be an idea to introduce
generic "invert_vsync=1" and "invert_hsync=1" options to the kernel
(since a buggy monitor will affect _all_ cards, not just radeon)

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

