Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262550AbTJTLfN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 07:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbTJTLfN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 07:35:13 -0400
Received: from mail.netbeat.de ([193.254.185.26]:41476 "HELO mail.netbeat.de")
	by vger.kernel.org with SMTP id S262550AbTJTLfG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 07:35:06 -0400
Subject: Re: 2.6.0-test8-mm1
From: Jan Ischebeck <mail@jan-ischebeck.de>
To: akpm@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1066649703.20369.11.camel@JHome.uni-bonn.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 20 Oct 2003 13:35:03 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

The new framebuffer code for ATI RADEON grfx cards doesn't work correct.

After startup the screen switches to an unsupported mode, flickers and
just shows a small line at the top.I get a freq of 87 hz instead of 60.

Zhuang:~# fbset
 
mode "1024x768-87"
    # D: 44.901 MHz, H: 35.523 kHz, V: 86.960 Hz
    geometry 1024 768 1024 768 8
    timings 22271 56 24 33 8 160 8
    laced true
    rgba 8/0,8/0,8/0,0/0
endmode

switching to 60 hz doesn't improve the flickering screen.
(fbset 1024x768-60)

Probably this is connected to a warning about '*dcc2*' function I got
compiling the Radeon driver. I will recompile later to see the warning
again.

my config:

CONFIG_DRM=y
# CONFIG_DRM_TDFX is not set
# CONFIG_DRM_GAMMA is not set
# CONFIG_DRM_R128 is not set
CONFIG_DRM_RADEON=y
# CONFIG_DRM_I810 is not set
# CONFIG_DRM_I830 is not set
# CONFIG_DRM_MGA is not set
# CONFIG_DRM_SIS is not set
...

Thanks for a new -mm kernel,

Jan
-- 
Jan Ischebeck <mail@jan-ischebeck.de>

