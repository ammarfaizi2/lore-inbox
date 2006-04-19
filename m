Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWDSQna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWDSQna (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 12:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750999AbWDSQna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 12:43:30 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:26642 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750975AbWDSQna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 12:43:30 -0400
Date: Wed, 19 Apr 2006 18:43:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] DEBUG_KERNEL menu cleanups
Message-ID: <20060419164328.GB25047@stusta.de>
References: <20060414111853.GG4162@stusta.de> <20060414123631.GA14263@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060414123631.GA14263@mars.ravnborg.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 14, 2006 at 02:36:31PM +0200, Sam Ravnborg wrote:
> On Fri, Apr 14, 2006 at 01:18:53PM +0200, Adrian Bunk wrote:
> > This patch contains the following possible cleanups:
> > - move DEBUG_FS above the DEBUG_KERNEL options (it did break the menu)
> > - let the following options depend on DEBUG_KERNEL:
> >   - PRINTK_TIME
> >   - DEBUG_SHIRQ
> >   - RT_MUTEX_TESTER
> >   - UNWIND_INFO
> 
> A simpler solution would be to wrap everything inside
> if DEBUG_KERNEL
> ...
> ...
> ...
> endif

It isn't that simple, since this if block would also contain

config LOG_BUF_SHIFT
        int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
        range 12 21
        ...




> 	Sam

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

