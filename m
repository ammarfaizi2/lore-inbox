Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751268AbWIIKz7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751268AbWIIKz7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 06:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWIIKz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 06:55:59 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:55775 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751268AbWIIKz6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 06:55:58 -0400
Message-ID: <45029DB0.5020300@garzik.org>
Date: Sat, 09 Sep 2006 06:55:44 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: v4l-dvb-maintainer@linuxtv.org, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: DVB build fails without I2C
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In an effort to speed up my all-filesystems build, I disabled several 
things in my allyesconfig-generated .config.  As luck would have it, I 
wound up disabling I2C but did not disable DVB.

This led to a link failure at the end of the build, with the linker 
complaining that many I2C-related symbols were not present.

Recommended solution:  Add I2C as a dependency (or select) in DVB Kconfig.

	Jeff


