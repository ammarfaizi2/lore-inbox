Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261763AbVEKWzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbVEKWzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 18:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVEKWzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 18:55:52 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57604 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261730AbVEKWxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 18:53:55 -0400
Date: Thu, 12 May 2005 00:53:54 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jan Dittmer <jdittmer@ppp0.net>, spyro@f2s.com, zippel@linux-m68k.org,
       starvik@axis.com, wli@holomorphy.com, linux-kernel@vger.kernel.org,
       kbuild-devel@lists.sourceforge.net, dev-etrax@axis.com,
       sparclinux@vger.kernel.org
Subject: Re: [kbuild-devel] select of non-existing I2C* symbols
Message-ID: <20050511225354.GL6884@stusta.de>
References: <20050302203812.092f80a0.akpm@osdl.org> <20050304105247.B3932@flint.arm.linux.org.uk> <20050304032632.0a729d11.akpm@osdl.org> <20050304113626.E3932@flint.arm.linux.org.uk> <20050506235842.A23651@flint.arm.linux.org.uk> <427C9DBD.1030905@ppp0.net> <20050507122622.C11839@flint.arm.linux.org.uk> <427CC082.4000603@ppp0.net> <20050507144135.GL3590@stusta.de> <20050508182050.GB8182@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050508182050.GB8182@mars.ravnborg.org>
User-Agent: Mutt/1.5.9i
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

I'd prefer 3) and fix up all problems.

E.g. i the case of the I2C* select's the current warnings seem to 
indicate possible configurations that do not compile.

> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

