Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261865AbVEDOzy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261865AbVEDOzy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 10:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbVEDOzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 10:55:54 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:5518 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id S261865AbVEDOzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 10:55:44 -0400
Message-ID: <4278E261.1080503@t-online.de>
Date: Wed, 04 May 2005 16:55:29 +0200
From: Tobias Margitan <t.margitan@t-online.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel panics with ide/pci hpt372
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: bjnkOUZfYew6FCqEyE2z3A0lk2HlIQRccrjVuVxdx8WYcqjaAubWZJ@t-dialin.net
X-TOI-MSGID: 4ed934df-fe21-4d42-bcdf-acf4c61faf7e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,
I got troubles with kernel panics shown below since 2.6.8

Distribution: Gentoo Linux 2005.0
Hardware Environment: Asus CUR-DLS Dual P3 / Serverworks Chip + Highpoint 372
softraid crap controller
Software Environment: 2.6.11, actual gentoo ~x86 tree
Problem Description: since 2.6.8 I get Kernel Panics in module hpt372 wich is
included in hpt366 driver

Steps to reproduce:
Since I use that controller due to unstabilities just as normal ide controller I
got no more trouble. But 2.6.7 was the las kernel that was able to bring hpt372
up. I dont need to boot from that device but my storage HDDs are on its line.
What I can see from the error is this, although there is quite more above that.
Screen begins with:

Process swapper (pid: 1, threadinfo=dffc1000 task=dffc0a40)
Stack: c0311375... <many more 8bit columns>
Call Trace: [<c0311375>] hpt372_tune_chipset+0xd5/0x160
next in call trace are more ide and htp related things connected to the stack
numbers
Code: ff 85 c0 ba... and more of 2 bit code
<0>Kernel panic - not syncing: Attempted to kill init!

and thats the point where I have to go with the reset button and be happy my
2.6.7 still exists :/

There were added three patches to the sources described in here:
http://www.kernel.org/pub/linux/kernel/v2.6/ChangeLog-2.6.8
just search the changelog for "hpt" and you'll find.
is it possible to undo that patches? at least one of them has to cause the errors...

I tried the Highpoint Own linux sources but when i modprobe them there is write errors
and it takes more than 5 minutes to load the first hdd in line and by the second one
the driver gives up trying.

thanks for reading


