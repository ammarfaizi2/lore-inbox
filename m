Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268913AbRHLBrG>; Sat, 11 Aug 2001 21:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268916AbRHLBq5>; Sat, 11 Aug 2001 21:46:57 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:36493
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S268913AbRHLBqm>; Sat, 11 Aug 2001 21:46:42 -0400
Date: Sat, 11 Aug 2001 18:46:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: ext3-users@redhat.com, Andrew Morton <akpm@zip.com.au>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: ext3-2.4-0.9.6
Message-ID: <20010811184640.B17435@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <3B75DE86.EEDFAFFB@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B75DE86.EEDFAFFB@zip.com.au>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 11, 2001 at 06:40:22PM -0700, Andrew Morton wrote:

> Patch against linux-2.4.8 is at
> 
> 	http://www.uow.edu.au/~andrewm/linux/ext3/
> 
> The only changes here are merging up to 2.4.8 and the bigendian
> fix.

Gack.  I think about when you wrote this, I managed to crash again.  I
was running 2.4.8-pre8 + fsync_dev -> fsync_no_super + first fix.  It
was at transaction.c:1184, but the logs didn't make it to disk.  On a
related note, what does ext3 do to the disk when this happens,  I
think I need to point the yaboot author at it since it couldn't
load a kernel (which was fun, let me tell you.. :))

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
