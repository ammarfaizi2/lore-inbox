Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWABBLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWABBLL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jan 2006 20:11:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932304AbWABBLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jan 2006 20:11:10 -0500
Received: from sccrmhc12.comcast.net ([63.240.77.82]:29903 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932303AbWABBLJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jan 2006 20:11:09 -0500
Date: Sun, 1 Jan 2006 20:14:31 -0500
From: Kurt Wall <kwall@kurtwerks.com>
To: Ochal Christophe <ochal@kefren.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need help with mtrr & agpgart
Message-ID: <20060102011431.GC5213@kurtwerks.com>
Mail-Followup-To: Ochal Christophe <ochal@kefren.be>,
	linux-kernel@vger.kernel.org
References: <1136163121.8522.10.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136163121.8522.10.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-Operating-System: Linux 2.6.15-rc6krw
X-Woot: Woot!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2006 at 01:52:01AM +0100, Ochal Christophe took 0 lines to write:
> I've been doing a little digging in my system since i was unable to get
> DRI running on my current motherboard (see my prior posts regarding a
> possible bug in agpgart), and i noticed that i don't get any lines
> in /proc/mtrr expect for my main memory.
> 
> The entry seems correct, the size specified is also correct, however, i
> don't get any write-combining lines.
> 
> This is what i get:
> 
> eg00: base=0x00000000 ( 0MB), size=1024MB: write-back, count=1
> 
> This is what i should get:
> eg00: base=0x00000000 ( 0MB), size=1024MB: write-back, count=1
> reg01: base=0xd0000000 (3328MB), size= 128MB: write-combining, count=1
> reg02: base=0xf0000000 (3840MB), size= 128MB: write-combining, count=1

I don't get much better on my AMD64 system:

$ cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size= 512MB: write-back, count=1
reg01: base=0x1ff00000 ( 511MB), size=   1MB: uncachable, count=1

Kurt
-- 
Be braver -- you can't cross a chasm in two small jumps.
