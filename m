Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUEWMrF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUEWMrF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 08:47:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbUEWMrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 08:47:05 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:49794 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S262772AbUEWMqw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 08:46:52 -0400
Date: Sun, 23 May 2004 07:46:46 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Sebastian <sebastian@expires0604.datenknoten.de>
cc: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange DMA-errors and system hang with SMART (was: ...and system
 hang with Promise 20268)
In-Reply-To: <1085049301.4485.18.camel@coruscant.datenknoten.de>
Message-ID: <Pine.GSO.4.21.0405230737040.9783-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Sorry it's taken me so long to reply.  My usual googling of smartmontools
didn't turn this up because you changed the subject line and started a new
thread.  You wrote:

> Further, there seems to be a known problem with SMART related to the
> hard drive that I am using:
> Device Model:     IC35L040AVER07-0

I hadn't realized until now that the drive is an IBM GXP60.

smartctl is *supposed* to print a warning message for these drives, to
tell users to look at http://www.geocities.com/dtla_update/index.html#rel
for pointers to updated firmware for this drive!  What firmware version do
you have?

If you do smartctl -P showall, you'll see that there is the following
entry -- but the regular expression doesn't match your drive because of
the '-0' and '-1' suffix (which usually indicates RAM cache size of the
disk drive).  I'll do a bit of research and then probably modify the
smartmontools regular expression to be sure to recognize the drive.

MODEL REGEXP:       IC35L0[12346]0AVER07
FIRMWARE REGEXP:    .*
ATTRIBUTE OPTIONS:  None preset; no -v options are required.
WARNINGS:           IBM Deskstar 60GXP drives may need upgraded SMART
firmware. Please see http://www.geocities.com/dtla_update/index.html#rel

Meanwhile, what firmware version do you have?  I suggest you upgrade it --
this may fix the problem.  The final firmware with the SMART fixes seems
to be A46A.

Cheers,
	Bruce



