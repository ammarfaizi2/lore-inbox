Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263024AbUHJJLx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263024AbUHJJLx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbUHJJJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:09:21 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:14981 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S263024AbUHJJIm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:08:42 -0400
Message-ID: <41189098.4000400@free.fr>
Date: Tue, 10 Aug 2004 11:08:40 +0200
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040808 Debian/1.7.2-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 2.6.8-rc4-mm1 : radeon_monitor.c broken vs CONFIG_FB_MODE_HELPERS
 + Hard freeze
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried 2.6.8-rc4-mm1 on my ASUS L3800C laptop (radeon 7500), defined 
CONFIG_FB_MODE_HELPERS and I have got a hard freeze when starting X and 
framebuffer console with a lot of yellow dot on the bottom screen. 
Suddently I hear the fan meaning the machine is dead

Trying to compile without CONFIG_FB_MODE_HELPERS set do not work because
drivers/video/aty/radeon_monitor.c unconditionnaly uses "vesa_modes" 
variable that depends on CONFIG_FB_MODE_HELPERS.

Defining vesa_modes unconditionnaly as it was previously does not help : 
machine freeze. Trying the pci=routeirq (as per 2.6.8-rc3-mm2)  make the 
machine to freeze immediately without even displaying something.

Due to compilation errors in 2.6.8-rc3-mm2, I did'nt tried it. 
2.6.8-rc3-mm1 was the best kernel even on this machine.

-- 
    __
   /  `                   	Eric Valette
  /--   __  o _.          	6 rue Paul Le Flem
(___, / (_(_(__         	35740 Pace

Tel: +33 (0)2 99 85 26 76	Fax: +33 (0)2 99 85 26 76
E-mail: eric.valette@free.fr



