Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTIZIrm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 04:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTIZIrl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 04:47:41 -0400
Received: from [61.78.75.145] ([61.78.75.145]:24467 "EHLO unfix.net")
	by vger.kernel.org with ESMTP id S262018AbTIZIrg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 04:47:36 -0400
Message-ID: <3F73FEC9.7090109@mytears.org>
Date: Fri, 26 Sep 2003 17:54:33 +0900
From: =?EUC-KR?B?waTFwr+1?= <master@mytears.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030922 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: In 2.6 kernel, there are 2 problems with Korean keyboard.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In Korean 106-key keyboard, there are two keys aren't working.

Those are, Korean/English Key, and Korean/Chinese Key.
These have scancode of 0xf2, and 0xf1 accordingly, also in xev, it were
recognised as 122 and 121.

In 2.4.xx kernel, these keys send the event correctly, however in
2.6.0_test5, it seems it has problem with sending key events.

It leaves following lines in the kernel log;

Sep 24 03:33:59 [kernel] atkbd.c: Unknown key (set 2, scancode 0xf1, on isa0060/serio0) pressed.
Sep 24 03:33:59 [kernel] atkbd.c: Unknown key (set 2, scancode 0xf2, on isa0060/serio0) pressed.


So I have tried to hack atkbd.c and assigned values to 0xf2 and 0xf1, now the kernel log seems fine but still, xev doesn't receive anything.

Also, while I was searching internet, I have found a patch for an old keyboard driver.
http://www.geocrawler.com/archives/3/2142/2002/2/0/7967619/

How would i be able to use these keys correctly in Kernel 2.6?

Regards


