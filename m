Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311686AbSCNRL1>; Thu, 14 Mar 2002 12:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311687AbSCNRLR>; Thu, 14 Mar 2002 12:11:17 -0500
Received: from ns.suse.de ([213.95.15.193]:63246 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S311686AbSCNRLJ>;
	Thu, 14 Mar 2002 12:11:09 -0500
Date: Thu, 14 Mar 2002 18:11:06 +0100
From: Dave Jones <davej@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Martin Dalecki <martin@dalecki.de>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Actually hide x86 IDE chipsets on !CONFIG_X86
Message-ID: <20020314181106.J19636@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Tom Rini <trini@kernel.crashing.org>,
	Martin Dalecki <martin@dalecki.de>,
	LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20020314165018.GE706@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020314165018.GE706@opus.bloom.county>; from trini@kernel.crashing.org on Thu, Mar 14, 2002 at 09:50:18AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 14, 2002 at 09:50:18AM -0700, Tom Rini wrote:
 > Hello.  The following actually hides x86-specific drivers on
 > !CONFIG_X86.  The problem is that dep_bool '...' CONFIG_FOO $CONFIG_BAR
 > doesn't have the desired effect if CONFIG_BAR isn't set.
 > 
 > +   if [ "$CONFIG_X86" = "y" ]; then
 > +      bool '  CMD640 chipset bugfix/support' CONFIG_BLK_DEV_CMD640
 > +      dep_bool '    CMD640 enhanced support' CONFIG_BLK_DEV_CMD640_ENHANCED $CONFIG_BLK_DEV_CMD640
 > +   fi

 I've a PCI card with one of these. It could in theory work on any arch
 with a PCI slot.
 
-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
