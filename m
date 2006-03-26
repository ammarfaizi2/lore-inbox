Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751143AbWCZJb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751143AbWCZJb0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 04:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbWCZJb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 04:31:26 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:2541 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751104AbWCZJbZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 04:31:25 -0500
Date: Sun, 26 Mar 2006 11:31:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Mikado <mikado4vn@gmail.com>
cc: linux-c-programming@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Virtual Serial Port
In-Reply-To: <4425FB22.7040405@gmail.com>
Message-ID: <Pine.LNX.4.61.0603261127580.22145@yvahk01.tjqt.qr>
References: <442582B8.8040403@gmail.com> <Pine.LNX.4.61.0603251945100.29793@yvahk01.tjqt.qr>
 <4425FB22.7040405@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> You could write a device driver implementing virtual serial ports. Then you 
>> just add an ioctl that connects/disconnects virtual ports to real ports if 
>> desired.
>> I do not quite see what this would be good for, but I am sure it's 
>> good for learning or for fun. :)
>
>My purpose is to provide serial interfaces for debugging. My real box
>acts as remote host connecting to VMWare box by a *virtual* serial cable
>so that I can set up a debugging environment.
>
Ah! You don't want to have the X11 overhead of VMware. Quite an idea.
If I get it right, your setup looks like:

  guest writes to /dev/ttyS0
  vmware connects its virtual S0 to the host's ttyFakeS0
  minicom on the host to ttyFakeS0
or even
  vmware S0 to host's ttyS0
  other remote machine do minicom to ttyS0

The reason for FakeS0 is that vmware does not know about ptys, 
unfortunately.


Jan Engelhardt
-- 
