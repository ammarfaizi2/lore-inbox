Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264520AbTLLJML (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 04:12:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264522AbTLLJML
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 04:12:11 -0500
Received: from [80.98.160.78] ([80.98.160.78]:13712 "EHLO zoli.localdomain")
	by vger.kernel.org with ESMTP id S264520AbTLLJMI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 04:12:08 -0500
Message-ID: <3FD98665.2030402@freemail.hu>
Date: Fri, 12 Dec 2003 10:12:05 +0100
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031114
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Multiple keyboard/monitor vs linux-2.6?
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is there a way to assign different keyboards to different vcs?
I would like to set up a machine that has 2 keyboards, 2 mice and
2 videocards and run XFree-4.x on both heads. The videocard/monitor and
mouse settings are easy to set up but I cannot find a device setting
for the keyboard in man XF86Config. How can I do it with mainline kernels?

After some googleing I found something called "backstreet ruby"
http://startx.times.lv/eng-faq.html
This gave me this info (howto in a nutshell):

1. Boot with kernel option "dumbcon=N" to activate N dummy console.
2. cat /proc/bus/input/devices gives the input devices, search for keyboard
    entries.
3. To assign a keyboard to a VT, feed the keyboard Phys= entry into
    a VT, e.g. echo "isa0060/serio0/input0" > /proc/bus/console/00/keyboard
4. Start the X server on the proper VT.

The functionality can be found at linuxconsole.sourceforge.net.
Will this be included into mainline near term? Say 2.6.[12]?
The ruby-2.6 is against 2.6.0-test9 so it's almost uptodate.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

