Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751043AbVLZIGR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751043AbVLZIGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 03:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVLZIGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 03:06:17 -0500
Received: from [210.76.114.20] ([210.76.114.20]:19367 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S1751042AbVLZIGR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 03:06:17 -0500
Message-ID: <43AFA467.6050504@ccoss.com.cn>
Date: Mon, 26 Dec 2005 16:05:59 +0800
From: liyu <liyu@ccoss.com.cn>
Reply-To: liyu@ccoss.com.cn
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: zh-cn,zh
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [Question] How to write one keyboard driver without changing hid-input?
Content-Type: text/plain; charset=gb18030; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone.

    I have a MS Natural Ergonomic Keyboard 4000 that have USB port.

    Under Windows XP, it work fine, however, Some extend keys do not 
work under Linux.
I found hid-input that do not report PRESS event to input-subsystem when 
such extend key
is pressed . I got this reason later, It map such "Zoom" key to 
KEY_UNKNOWN, and ignore them.
Its keymap is hard-coded.

    I try to write one driver for this keyboard now. but I found if we 
do not change or copy
hid-input.c, then I must write a lot of code to support it. Which guru 
wrote driver like
this under hid_input support? Would you like give some tips?

    I think this driver is simple. It only need we emit some event when 
key related is pressed,
do not need input event handler.
   
    Thanks in advanced.

-liyu
