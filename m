Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262211AbVCCRAE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262211AbVCCRAE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 12:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVCCQ7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 11:59:31 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:27142 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262181AbVCCQ4x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 11:56:53 -0500
Date: Thu, 3 Mar 2005 17:56:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: RFC: disallow modular framebuffers
Message-ID: <20050303165649.GF4608@stusta.de>
References: <20050301024118.GF4021@stusta.de> <200503012115.29023.adaplas@hotpop.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503012115.29023.adaplas@hotpop.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 01, 2005 at 09:15:27PM +0800, Antonino A. Daplas wrote:
> On Tuesday 01 March 2005 10:41, Adrian Bunk wrote:
> > Hi,
> >
> > while looking how to fix modular FB_SAVAGE_* (both FB_SAVAGE_I2C=m and
> > FB_SAVAGE_ACCEL=m are currently broken) I asked myself:
> 
> BTW, what's the problem with the above?

  #if defined(CONFIG_FB_SAVAGE_ACCEL)

doesn't work with FB_SAVAGE_ACCEL=m, and

  #if defined(CONFIG_FB_SAVAGE_ACCEL) || defined(CONFIG_FB_SAVAGE_ACCEL_MODULE)

would break with FB_SAVAGE=y and FB_SAVAGE_ACCEL=m.


Is there any reason for these being three modules?
It seems the best solution would be to make this one module composed of 
up to three object files?


> Tony

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

