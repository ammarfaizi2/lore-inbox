Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262556AbVCPMOg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262556AbVCPMOg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 07:14:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262552AbVCPMOR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 07:14:17 -0500
Received: from mxout.hispeed.ch ([62.2.95.247]:9602 "EHLO smtp.hispeed.ch")
	by vger.kernel.org with ESMTP id S262553AbVCPMNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 07:13:55 -0500
Message-ID: <423822FA.6020501@hispeed.ch>
Date: Wed, 16 Mar 2005 13:13:46 +0100
From: Roland Scheidegger <rscheidegger_lists@hispeed.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8b) Gecko/20050217
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: Dave Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
       dri-devel@lists.sourceforge.net
Subject: Re: Another drm/dri lockup - when moving the mouse
References: <423802E6.1020308@aitel.hist.no>
In-Reply-To: <423802E6.1020308@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> I have reported this before, but now I have some more data.
> 
> I have an office pc with this video card:
> VGA compatible controller: ATI Technologies Inc Radeon RV100 QY [Radeon 
> 7000/VE]
> 
> In previous reports I found that starting xfree or xorg with dri support
> cause a hang after a little while.  It seems that this only happens when
> the mouse moves.  Something I didn't discover before because there
> are lots of unplanned mouse movements - the thing is sensitive and jumps
> a pixel now and then when I move stuff on the desk.
What xorg / xfree / drm versions are you talking about?

> Taking care not to move the mouse, I can start X and run glxgears
> with acceleration.  The slightest mouse movement during 3D activity
> kills the machine instantly so it only responds to the reset button.  Mouse
> movement without 3D activity may or may not kill the pc.
> 
> Could there be a problem where 3D-stuff and code to move the mouse
> "steps on each other toes" somehow?  Or some way to test this further,
> by disabling the mouse or force some kind of software fallback for
> the mouse cursor?
You could use Option "SWcursor" "true".
Since it crashes even without 3d sometimes, the problem does not seem to 
be related to dri (as in, dri driver). Sounds more like it's related to 
CP activity. Not sure what would cause this, there seem to be a lot of 
mouse cursor movement crashes reported lately... Do you have a USB mouse 
whose controller shares the IRQ with the graphic card maybe?

Roland
