Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275075AbTHLGYA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 02:24:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275076AbTHLGYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 02:24:00 -0400
Received: from antimatter.casa-z.org ([64.32.175.22]:25094 "EHLO
	antimatter.fatooh.org") by vger.kernel.org with ESMTP
	id S275075AbTHLGX6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 02:23:58 -0400
Message-ID: <3F388801.9030908@fatooh.org>
Date: Mon, 11 Aug 2003 23:24:01 -0700
From: Corey Hickey <bugfood-ml@fatooh.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b; MultiZilla v1.4.0.4A) Gecko/20030719
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test3 XF86Config-4 mouse resolution doesn't work
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

In my XF86Config-4 file, I have my mouse set to use the "Resolution"
option, in order to have faster pointer motion without using
acceleration. This worked fine in 2.4.21, but now that I'm trying out
2.6.0-test3 it doesn't seem to work. That is, changing the value of
"Resolution" has no effect whatsoever. The mouse is slow, like it used
to be in 2.4 before I added the Resolution option.

I know I can use "xset m" to adjust the acceleration, but I very much
prefer to be able to have the mouse constant-speed, yet faster than
default.

----

This is my first post to this list, so please let me know if I am
forgetting any information that I ought to have included.

-- Debian Woody (testing)

-- XFree86 Version 4.2.1.1 (Debian 4.2.1-6 20030225230350
branden@progeny.com)

-- Microsoft Wheel Mouse Optical (This is a USB-PS/2 combo, but plugged
into the PS/2 port.

-- Here's the mouse definition in my XF86Config-4:
Section "InputDevice"
         Identifier      "Intellimouse"
         Driver          "mouse"
         Option          "Device"                "/dev/input/mice"
         Option          "Protocol"              "IMPS/2"
         Option          "Buttons"               "5"
         Option          "ZAxisMapping"          "4 5"
         Option          "Resolution"            "200"
EndSection

-- This is (hopefully) the relevant parts of my kernel .config:
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
CONFIG_INPUT_JOYDEV=m

CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=y
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_INPORT is not set
# CONFIG_MOUSE_LOGIBM is not set
# CONFIG_MOUSE_PC110PAD is not set

-----

If I left anything out here are links to my full logs and configurations
for the kernel and X:

http://bugfood.casa-z.org/k/config-2.4.21.txt
http://bugfood.casa-z.org/k/config-2.6.0-test3.txt
http://bugfood.casa-z.org/k/messages.txt

http://bugfood.casa-z.org/k/XF86Config-4.txt
http://bugfood.casa-z.org/k/XFree86.3.log.txt


Thanks for the help,
Corey

