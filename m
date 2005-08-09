Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbVHIAnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbVHIAnn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 20:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVHIAnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 20:43:43 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:14024 "EHLO
	mta09-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S932390AbVHIAnn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 20:43:43 -0400
Message-ID: <42F7FD5E.6000107@gentoo.org>
Date: Tue, 09 Aug 2005 01:48:30 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050723)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, mog.johnny@gmx.net
Subject: irqpoll causing some breakage?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I recently added the irqpoll patch to Gentoo's 2.6.12 kernels, using this patch:

http://dev.gentoo.org/~dsd/genpatches/trunk/2.6.12/2700_irqpoll.patch

Since then, I've had a few reports of minor breakage, but this is the first 
one I've been able to get full info on.

Hans-Christian Armingeon (on CC) owns a a combined USB keyboard-mouse, which 
is broken when the irqpoll patch is applied.

input: USB HID v1.00 Keyboard [Cherry GmbH Cherry Slim Line Trackball 
Keyboard] on usb-0000:00:10.0-1
input: USB HID v1.00 Mouse [Cherry GmbH Cherry Slim Line Trackball Keyboard] 
on usb-0000:00:10.0-1

After the irqpoll patch has been applied, the mouse does not work (the 
keyboard works fine..!). This is without the irqpoll/irqfixup parameters, 
although adding them does not help either. No errors appear, as far as I can see.

The problem also exists in an unpatched 2.6.13_rc6.

dmesg here: https://bugs.gentoo.org/attachment.cgi?id=65470
full bug: https://bugs.gentoo.org/show_bug.cgi?id=101463

I realise that this is probably not enough information to make any sense out 
of! Please let me know how we can help further.

Thanks,
Daniel
