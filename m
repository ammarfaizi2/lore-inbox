Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265006AbUELEPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265006AbUELEPh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 May 2004 00:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUELEPh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 May 2004 00:15:37 -0400
Received: from web14929.mail.yahoo.com ([216.136.225.94]:28854 "HELO
	web14929.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265006AbUELEPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 May 2004 00:15:36 -0400
Message-ID: <20040512041534.55600.qmail@web14929.mail.yahoo.com>
Date: Tue, 11 May 2004 21:15:34 -0700 (PDT)
From: Jon Smirl <jonsmirl@yahoo.com>
Subject: first PCI probe vs hotplug app on initramfs
To: lkml <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Over on the fbdev and dri list were having a big discussion about where to do
mode setting of the graphics hardware.  The normal kernel boot process follow
these steps...

1) kernel probes PCI hardware for built in drivers
2) driver gets probe and triggers hotplug event
3) what can happen here???
4) hotplug event runs early user space program on initramfs

The discussion is centering around what are the side effects of moving the
initialization of the display monitor from step #2 to step #4. There is no
consensus on what can happen in step #3. Do these early hotplug events run
synchronously or asynchronously? Will all of the other drivers initialize before
running the event?



=====
Jon Smirl
jonsmirl@yahoo.com


	
		
__________________________________
Do you Yahoo!?
Yahoo! Movies - Buy advance tickets for 'Shrek 2'
http://movies.yahoo.com/showtimes/movie?mid=1808405861 
