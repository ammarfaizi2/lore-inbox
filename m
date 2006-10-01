Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751876AbWJABXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbWJABXY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 21:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751879AbWJABXY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 21:23:24 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:49641 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751876AbWJABXX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 21:23:23 -0400
Message-ID: <451F1887.3040102@garzik.org>
Date: Sat, 30 Sep 2006 21:23:19 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: v4l-dvb-maintainer@linuxtv.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: zoran driver breaks 'make all{yes,mod}config'
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current linux-2.6.git doesn't build anymore:

   CC [M]  drivers/media/video/zoran_driver.o
drivers/media/video/zoran_driver.c: In function ‘setup_fbuffer’:
drivers/media/video/zoran_driver.c:1519: error: ‘PCIAGP_FAIL’ undeclared 
(first use in this function)
drivers/media/video/zoran_driver.c:1519: error: (Each undeclared 
identifier is reported only once
drivers/media/video/zoran_driver.c:1519: error: for each function it 
appears in.)

Same build breakage in bt484, saa7134.

The PCIAGP_FAIL symbol doesn't exist anywhere.

