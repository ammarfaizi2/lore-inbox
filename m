Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130183AbRBWXDa>; Fri, 23 Feb 2001 18:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130286AbRBWXDU>; Fri, 23 Feb 2001 18:03:20 -0500
Received: from citadel.myri.com ([199.120.212.1]:12416 "EHLO myri.com")
	by vger.kernel.org with ESMTP id <S130183AbRBWXDE>;
	Fri, 23 Feb 2001 18:03:04 -0500
Date: Fri, 23 Feb 2001 15:03:01 -0800
From: Bob Felderman <feldy@myri.com>
Message-Id: <200102232303.PAA20963@frisbee.myri.com>
To: linux-kernel@vger.kernel.org
Subject: re: possible bug x86 2.4.2 SMP in IP receive stack
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

=> From feldy Fri Feb 23 14:13:08 2001
=>
=> Feb 23 12:42:30 rcc2 kernel: Warning: kfree_skb passed an skb still on a list (from c01f58dc).
=>
=> I'm going to pop out one processor on the receiver
=> and see if that makes the problem go away.

Using a single processor on the receive side makes the problem go away.
I see no problems on the receiver with one cpu removed.

rcc2 29% netstat -i myri0 
Kernel Interface table
Iface   MTU Met    RX-OK RX-ERR RX-DRP RX-OVR    TX-OK TX-ERR TX-DRP TX-OVR Flg
eth0   1500   0    37857      0      0      0    36404      0      0      0 BRU
lo    16192   0       46      0      0      0       46      0      0      0 LRU
myri0  9000   0 20564644      0      0      0      312      0      0      0 BRU



