Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVBHPjj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVBHPjj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 10:39:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbVBHPji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 10:39:38 -0500
Received: from lon-del-02.spheriq.net ([195.46.50.98]:56716 "EHLO
	lon-del-02.spheriq.net") by vger.kernel.org with ESMTP
	id S261543AbVBHPh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 10:37:56 -0500
Message-ID: <4208DB49.D5E29AB1@st.com>
Date: Tue, 08 Feb 2005 16:31:21 +0100
From: Orazio PRIVITERA <orazio.privitera@st.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Orazio Privitera <orazio.privitera@st.com>
Subject: Information about Multiple independent framebuffer console on different 
 fb devices
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-O-Virus-Status: No
X-O-URL-Status: Not Scanned
X-O-CSpam-Status: Not Scanned
X-O-Spam-Status: Not scanned
X-O-Image-Status: Not Scanned
X-O-Att-Status: No
X-SpheriQ-Ver: 1.8.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I would like to get some information about multiple independent
framebuffer consoles on different fb devices.
Basically I'm working with a scenario of two independent video decoding
pipeline which allows to get two video displayed on two TV.
In this context, I would like to manage two independent framebuffers on
each video decoding. So, is it possible to have  2 concurrent virtual
consoles running on the two monitors simultaneously (for example two
independent console on the /dev/fb0 and /dev/fb1 framebuffers at the
same time) ? 

Looking at the register_framebuffer function, when the first frame
buffer device /dev/fb0 is registered, it calls the take_over_console
function (exported by drivers/char/console.c) in order to actually set
up the current frame buffer as the system console. But, when the second
framebuffer (/dev/fb1) is registered, the register_framebuffer function
doesn't set any system console for the /dev/fb1 device.

Is there some linux kernel version (or patch) which allows to manage the
described scenario?

Thanks a lot for any feedback,

Best regards

OP.
