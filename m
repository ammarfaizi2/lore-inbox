Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262654AbVCPP75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262654AbVCPP75 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 10:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbVCPP75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 10:59:57 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:58841 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262654AbVCPP7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 10:59:53 -0500
Message-ID: <423857EF.4080705@hispeed.ch>
Date: Wed, 16 Mar 2005 16:59:43 +0100
From: Roland Scheidegger <rscheidegger_lists@hispeed.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: Another drm/dri lockup - when moving the mouse
References: <423802E6.1020308@aitel.hist.no> <423822FA.6020501@hispeed.ch> <42383A27.9060101@aitel.hist.no>
In-Reply-To: <42383A27.9060101@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
>> Since it crashes even without 3d sometimes, the problem does not
>> seem to be related to dri (as in, dri driver).
> 
> 
> Stable as rock, _if_  Load "dri" is commented out from xorg.conf (or
>  from XF86Config-4)
Well, commenting that out makes the 2d ddx driver not to use the CP, drm
etc.

Almost sounds like a hardware issue to me, very few people have problems 
when only using 2d (dri loaded or not) with the radeon driver (as far as 
I can tell). You could try using pci gart instead of agp, if there's a 
problem with your agp bridge (not sure if that would help though in that 
case), Option "BusType" "PCI" (old xorg versions might not understand 
that option however, they might have a boolean "ForcePCIMode" option 
instead).

Roland
