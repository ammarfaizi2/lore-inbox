Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266795AbSLSXGS>; Thu, 19 Dec 2002 18:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267076AbSLSXGR>; Thu, 19 Dec 2002 18:06:17 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:24070 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266795AbSLSXGQ>; Thu, 19 Dec 2002 18:06:16 -0500
Date: Thu, 19 Dec 2002 23:14:15 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       linux-fbdev-devel@lists.sourceforge.net
Subject: Type confusion in fbcon
Message-ID: <20021219231415.A25145@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm in the midst of porting sa1100fb over to the new fb API, and I stumbled
across an apparant confusion over the type of fb_info->pseudo_palette.

Some code appears to think its an unsigned long, others think its u32.
This doesn't make much difference when sizeof(unsigned long) == sizeof(u32)
but this isn't always the case (eg, 64-bit architectures).

I'll get back to bashing the sa1100fb driver to work out why fbcon is
producing a _completely_ blank display, despite characters being written
to it.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

