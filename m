Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262920AbVEHS3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262920AbVEHS3T (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 May 2005 14:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbVEHS3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 May 2005 14:29:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:32012 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262920AbVEHS3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 May 2005 14:29:15 -0400
Date: Sun, 8 May 2005 19:28:59 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Adrian Bunk <bunk@stusta.de>, Jan Dittmer <jdittmer@ppp0.net>,
       spyro@f2s.com, zippel@linux-m68k.org, starvik@axis.com,
       wli@holomorphy.com, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net, dev-etrax@axis.com,
       sparclinux@vger.kernel.org
Subject: Re: [kbuild-devel] select of non-existing I2C* symbols
Message-ID: <20050508192859.D18084@flint.arm.linux.org.uk>
Mail-Followup-To: Sam Ravnborg <sam@ravnborg.org>,
	Adrian Bunk <bunk@stusta.de>, Jan Dittmer <jdittmer@ppp0.net>,
	spyro@f2s.com, zippel@linux-m68k.org, starvik@axis.com,
	wli@holomorphy.com, linux-kernel@vger.kernel.org,
	kbuild-devel@lists.sourceforge.net, dev-etrax@axis.com,
	sparclinux@vger.kernel.org
References: <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <20050506235842.A23651@flint.arm.linux.org.uk> <427C9DBD.1030905@ppp0.net> <20050507122622.C11839@flint.arm.linux.org.uk> <427CC082.4000603@ppp0.net> <20050507144135.GL3590@stusta.de> <20050508182050.GB8182@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050508182050.GB8182@mars.ravnborg.org>; from sam@ravnborg.org on Sun, May 08, 2005 at 08:20:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 08, 2005 at 08:20:50PM +0200, Sam Ravnborg wrote:
> > Shouldn't kconfig exit with an error if a not available symbol gets
> > selected?
> No. There are meny configurations where we select a symbol that is
> only visible in some configurations.
> 
> Several possibilities exists:
> 1) Silently ignore SELECT SYMBOL when SYMBOL is undefined
> 2) Warn - as we do today
> 3) Error out as you suggest
> 
> Option 1) is preferable for 'make oldconfig' simply because target group
> here do not care. But it would be nice to know when one do a typing
> error in SELECT. So one *config target should continue to warn about it.

I disagree.

Consider that some developers do not use anything other than "make
oldconfig" so having this silently ignore stuff means that these
folk never get the warnings.  I myself fall into this category.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
