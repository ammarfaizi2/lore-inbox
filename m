Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262027AbVDFILk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbVDFILk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 04:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVDFILk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 04:11:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:52938 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262027AbVDFIL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 04:11:29 -0400
Subject: Re: Info Regarding how the Redeon driver access EDID info
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: karthik <karthik.r@samsung.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <200504061346.36975.karthik.r@samsung.com>
References: <200504061346.36975.karthik.r@samsung.com>
Content-Type: text/plain
Date: Wed, 06 Apr 2005 18:10:54 +1000
Message-Id: <1112775054.9568.143.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-04-06 at 13:46 -0700, karthik wrote:
> Hi,
> 
>           I am not able to understand how the radeon video card  
> driver access EDID info of Monitors attached to the cards.The 
> driver is calling one funtion 
> get_property(dp, propnames[i], NULL);

This is specific to PowerMacs where the EDID is stored there by the
firmware.

> But in this funtion its just return some value ie 
> dp->property->value; how this property->value field is 
> Initialized. Is this get_EDID is called only at boot time. how the value of 
> the device _node structure is initilized.
> 
> If any have any ideas regarding this please mail me.

This is all done by the firmware. radeonfb can also directly get the
EDID from the monitor though via DDC2 (i2c). Look at
drivers/video/aty/radeon_i2c.c and radeon_monitor.c

Ben.


