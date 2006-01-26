Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751375AbWAZVgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375AbWAZVgZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbWAZVgY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:36:24 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:2736 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751413AbWAZVgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:36:24 -0500
Date: Thu, 26 Jan 2006 22:36:12 +0100
From: Pavel Machek <pavel@suse.cz>
To: seife@suse.de, kernel list <linux-kernel@vger.kernel.org>
Subject: Suspend to RAM: help with whitelist wanted
Message-ID: <20060126213611.GA1668@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On www.sf.net/projects/suspend , there's s2ram.c program for
suspending machines. It contains whitelist of known machines, along
with methods to get their video working (similar to
Doc*/power/video.txt). Unfortunately, video.txt does not allow me to
fill in whitelist automatically, so I need your help.

I do not yet have solution for machines that need vbetool; fortunately
my machines do not need that :-), and it is pretty complex (includes
x86 emulator).

Routine I'd like you to modify looks like:

        if (!strcmp(sys_vendor, "IBM")) {
                if (!strcmp(sys_version, "ThinkPad X32")) {
                        machine_known();
                        set_acpi_video_mode(3);
                        radeon_backlight_off();
                        return;
                }
        }

... so it is pretty easy (but any patches are welcome).

								Pavel
-- 
Thanks, Sharp!
