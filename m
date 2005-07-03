Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261387AbVGCHJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261387AbVGCHJm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Jul 2005 03:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261389AbVGCHJm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Jul 2005 03:09:42 -0400
Received: from wproxy.gmail.com ([64.233.184.198]:17291 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261387AbVGCHJi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Jul 2005 03:09:38 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FvezIQo7rxKfXCNeXd7C4AbgcEAT7ktsTfWVvpijcUhBthHnS6KyxYhd8S2ZnS92DLYVqUGkTrpdY1256eoh+i40TwzP49Etr1JB8OD7JfoWdeQbmBxqtPPK8PH01dE82KQ8oS7kFAR3Mzb5CTauGrBSXzi3zOWbGU2aBXP+y1M=
Message-ID: <a44ae5cd05070300097a18790a@mail.gmail.com>
Date: Sun, 3 Jul 2005 00:09:33 -0700
From: Miles Lane <miles.lane@gmail.com>
Reply-To: Miles Lane <miles.lane@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.13-rc1-mm1 -- Synaptics touchpad not detected correctly
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Any ideas why my Synaptics touchpad isn't getting recognized
as supporting multi-finger tap detection?  I haven't seen detection
work with earlier kernels, either.  However, multifinger taps work
under WinXP.

dmesg is reporting:

           Synaptics Touchpad, model: 1, fw: 5.10, id: 0x258eb1, caps:
0xa04713/0x0
           input: SynPS/2 Synaptics TouchPad on isa0060/serio1

On the web, I found this reference:
http://www.softwarelibremorelos.gob.mx/pipermail/slm/2005-March/001267.html
Which, for 2.6.10, shows:
           Synaptics Touchpad, model: 1
            Firmware: 5.10
            Sensor: 37
            new absolute packet format
            Touchpad has extended capability bits
            -> multifinger detection
            -> palm detection
           input: SynPS/2 Synaptics TouchPad on isa0060/serio1

My .config contains:

CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1280
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
# CONFIG_INPUT_TSDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_LKKBD is not set
# CONFIG_KEYBOARD_XTKBD is not set
# CONFIG_KEYBOARD_NEWTON is not set
CONFIG_INPUT_MOUSE=y
CONFIG_MOUSE_PS2=m

CONFIG_SERIO=y
CONFIG_SERIO_I8042=y
CONFIG_SERIO_SERPORT=m
CONFIG_SERIO_CT82C710=m
CONFIG_SERIO_PCIPS2=m
CONFIG_SERIO_LIBPS2=y
