Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262648AbULPIgg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262648AbULPIgg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 03:36:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262647AbULPIgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 03:36:35 -0500
Received: from styx.suse.cz ([82.119.242.94]:1458 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S262651AbULPIdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 03:33:35 -0500
Date: Thu, 16 Dec 2004 09:34:57 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Eric Lammerts <eric@lammerts.org>
Cc: linux-kernel@vger.kernel.org, lineak-devel@lists.sourceforge.net
Subject: Re: Linux input event extending tool exist?
Message-ID: <20041216083457.GA21199@ucw.cz>
References: <200412101638.05125.aivils@unibanka.lv> <20041210142044.GB20511@ucw.cz> <41C11202.2040009@lammerts.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C11202.2040009@lammerts.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2004 at 11:41:38PM -0500, Eric Lammerts wrote:

> Vojtech Pavlik wrote:
> >You can use evtest (attached). It's often found in the joystick RPMs.
> >It's also in the linuxconsole.sf.net CVS repository.  On recent kernels
> >it'll show the scancodes as well as the generated keycodes.
> 
> Vojtech, are you aware that this doesn't work well with 32-bit apps on 
> x86-64 kernels? The ioctls don't work (no compat definitions), and 
> struct input_event is 24 bytes instead of 16.
 
Yes, I'm aware of that, and I don't have a solution for it yet, since
adding compat ioctls is easy, but using the right input_event size is
next to impossible.

The problem is with the difference in size of struct timeval.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
