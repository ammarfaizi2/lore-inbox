Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261613AbVBODla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261613AbVBODla (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 22:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVBODla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 22:41:30 -0500
Received: from mta10.srv.hcvlny.cv.net ([167.206.5.85]:40230 "EHLO
	mta10.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261613AbVBODlL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 22:41:11 -0500
Date: Mon, 14 Feb 2005 22:14:41 -0500 (EST)
From: vcjones@networkingunlimited.com (Vincent C Jones)
Subject: Re: Radeon FB troubles with recent kernels
In-reply-to: <3xVku-kH-15@gated-at.bofh.it>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: mpm@selenic.com
Message-id: <20050215031441.EFABE1DDFE@X31.nui.nul>
Organization: Networking Unlimited, Inc.
Content-transfer-encoding: 7BIT
Newsgroups: linux.kernel
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3xVku-kH-15@gated-at.bofh.it> you write:
>On my Thinkpad T30 with a Radeon Mobility M7 LW, I get interesting
>console video corruption if I start GDM, switch back to text mode,
>then stop it again. X is Xfree86 from Debian/unstable or X.org 6.8.2.
>
>The corruption shows up whenever the console scrolls after X has been
>shut down and manifests as horizontal lines spaced about 4 pixel rows
>apart containing contents recognizable as the X display. Switch from
>vt1 to vt2 and back or visual bell clears things back to normal, but
>corruption will reappear on the next scroll.
>
>This has appeared in at least 2.6.11-rc3-mm2 and rc4.

On my Thinkpad X31 with a Radeon Mobility M6 LY I see a major
regression going from 2.6.11-rc3 to rc4. With rc-4, the frame
buffer console (using "video=radeonfb:1024x768-24@60") comes up as
640x480 expanded to 1024x768. The inability of ACPI suspend to turn
off the backlight also returns. Using rc-3, frame buffer console
works fine and suspend/resume appears to work reliably without
needing radeontool to turn off the backlight (as long as I do it
from X.org X).

-- 
Dr. Vincent C. Jones, PE              Expert advice and a helping hand
Computer Network Consultant           for those who want to manage and
Networking Unlimited, Inc.            control their networking destiny
Phone: +1 201 568-7810
14 Dogwood Lane, Tenafly, NJ 07670
VCJones@NetworkingUnlimited.com     http://www.networkingunlimited.com
