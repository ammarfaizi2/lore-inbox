Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264545AbUABExB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 23:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264601AbUABExA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 23:53:00 -0500
Received: from mail.ms.so-net.ne.jp ([202.238.82.30]:55792 "EHLO
	mx03.ms.so-net.ne.jp") by vger.kernel.org with ESMTP
	id S264545AbUABEw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 23:52:57 -0500
Message-ID: <3FF4F8EA.6090602@turbolinux.co.jp>
Date: Fri, 02 Jan 2004 13:51:54 +0900
From: Go Taniguchi <go@turbolinux.co.jp>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ja-JP; rv:1.4) Gecko/20030925
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: vojtech@suse.cz
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.1-rc1 with JP106 keyboard
References: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0312310033110.30995@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Vojtech Pavlik:
>   o Fixes for keyboard 2.4 compatibility
> 

Hi,
2.6.1-rc1 with JP106 keybord. keycode was changed....
                                         2.6.0 -> 2.6.1-rc1
lower-right backslash (scancode 0x73)   89    -> 181
upper-right backslash (scancode 0x7d)   183   -> 182

at atkbd_set2_keycode in drivers/input/keyboard/atkbd.c

-       122, 89, 40,120, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0,  0,
+         0,181, 40,  0, 26, 13,  0,  0, 58, 54, 28, 27,  0, 43,  0,194,
              ^ scancode 0x73

-        85, 86, 90, 91, 92, 93, 14, 94, 95, 79,183, 75, 71,121,  0,123,
+         0, 86,193,192,184,  0, 14,185,  0, 79,182, 75, 71,124,  0,  0,
                                                  ^ scancode 0x7d
Is this correct?
2.6.0 is OK, but 2.6.1-rc1 does not get [|/_] keys.

