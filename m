Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262725AbVCPSPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262725AbVCPSPn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 13:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbVCPSPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 13:15:43 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55048 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262725AbVCPSPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 13:15:33 -0500
Date: Wed, 16 Mar 2005 19:15:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: chas3@users.sourceforge.net
Cc: shemminger@osdl.org, bridge@osdl.org,
       linux-atm-general@lists.sourceforge.net, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] fix bridge <-> ATM compile error
Message-ID: <20050316181532.GA3251@stusta.de>
References: <20050315121930.GE3189@stusta.de> <200503161611.j2GGBT0F004479@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503161611.j2GGBT0F004479@ginger.cmf.nrl.navy.mil>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2005 at 11:11:29AM -0500, chas williams - CONTRACTOR wrote:
> In message <20050315121930.GE3189@stusta.de>,Adrian Bunk writes:
> >This patch fixes the following compile error with CONFIG_BRIDGE=y and 
> >CONFIG_ATM_LANE=m:
> 
> isnt the problem more that CONFIG_ATM=m not CONFIG_ATM_LANE=m?
> perhaps CONFIG_BRIDGE should be dependent on CONFIG_ATM.  if
> atm is a module then bridge cannot be a module (unless the 
> hooks are moved from atm to bridge)?

The problem is currently CONFIG_ATM_LANE due to the #ifdef's in 
net/atm/common.c .

Letting CONFIG_BRIDGE depend on CONFIG_ATM doesn't sound like a good 
idea, since I doubt all people using the Bridge code require ATM 
support.

Moving the hooks to the bridge code will give you exactly the same 
problems the other way round.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

