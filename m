Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311678AbSCNRY2>; Thu, 14 Mar 2002 12:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311688AbSCNRYS>; Thu, 14 Mar 2002 12:24:18 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:44929
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S311678AbSCNRYI>; Thu, 14 Mar 2002 12:24:08 -0500
Date: Thu, 14 Mar 2002 10:24:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dave Jones <davej@suse.de>, Martin Dalecki <martin@dalecki.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Actually hide x86 IDE chipsets on !CONFIG_X86
Message-ID: <20020314172402.GG706@opus.bloom.county>
In-Reply-To: <20020314165018.GE706@opus.bloom.county> <20020314181106.J19636@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020314181106.J19636@suse.de>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 06:11:06PM +0100, Dave Jones wrote:
> On Thu, Mar 14, 2002 at 09:50:18AM -0700, Tom Rini wrote:
>  > Hello.  The following actually hides x86-specific drivers on
>  > !CONFIG_X86.  The problem is that dep_bool '...' CONFIG_FOO $CONFIG_BAR
>  > doesn't have the desired effect if CONFIG_BAR isn't set.
>  > 
>  > +   if [ "$CONFIG_X86" = "y" ]; then
>  > +      bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640
>  > +      dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
>  > +   fi
> 
>  I've a PCI card with one of these. It could in theory work on any arch
>  with a PCI slot.

A 640 and not a 646?

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
