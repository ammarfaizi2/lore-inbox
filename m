Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWIHHgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWIHHgu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 03:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbWIHHgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 03:36:50 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:64492 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750706AbWIHHgt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 03:36:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=cfp5yTbCD0l3dqpZnFBvvzrZg03sUHlxaa/9EMcRxk4TGab8pEwhkrcgvdqkeu8i5ja4Ah5+SCuOtIWnvGTREVV4b0Zgxi7cfdi4Yjiqdg3WVPq8/p3PLMe2Xs67YvO1KBbwUbNuz/90QOIqxSnQdYO5Rcjc7Yq+LP8aov3GGMc=
Message-ID: <24c1515f0609080036m21ffcef0ob576b5709e5ec6ce@mail.gmail.com>
Date: Fri, 8 Sep 2006 10:36:48 +0300
From: "Janne Karhunen" <janne.karhunen@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: debugging a deadlock
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sometimes you have to do strange things such as trying to debug occasional
deadlock of a system that has been in use for long, long time. So please, no
nasty comments about outdated system with no soft lock-up detection and
such :/

Anyhoo, it appears to be infinite semaphore wait. By modifying the semaphores
to dump stack on LONG wait I managed to get a stack trace. Looks like this:

kernel:    [printk+340/384] [printk+340/384] [show_trace+203/240]
[show_trace+203/240] [show_stack+113/120] [show_registers+223/324]
kernel:    [__down+147/276] [__down_failed+8/12]
[stext_lock+13538/52069] [error_code+16/64] [system_call+66/76]

Umm, this error_code thing is beyond my current knowledge. What's this?
Some sort of assembly-glued exception handling? Any ideas how to figure
out which semaphore this is?


-- 
// Janne
