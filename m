Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131352AbRC3Mh4>; Fri, 30 Mar 2001 07:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131353AbRC3Mhr>; Fri, 30 Mar 2001 07:37:47 -0500
Received: from stone.bestlinux.net ([213.168.19.162]:65263 "EHLO
	maddy.bestlinux.net") by vger.kernel.org with ESMTP
	id <S131352AbRC3Mhh>; Fri, 30 Mar 2001 07:37:37 -0500
Message-ID: <3AC47DD4.F4CC98BC@bestlinux.net>
Date: Fri, 30 Mar 2001 14:36:36 +0200
From: Anton Safonov <Anton.Safonov@bestlinux.net>
Organization: SOT Finnish Software Engineering Ltd.
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-24 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: David Hinds <dhinds@zen.stanford.edu>
Subject: PCMCIA problems on IBM ThinkPad 600X
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I have a problem with PCMCIA support on this IBM ThinkPad 600X.

kernel - 2.4.2 + patch-2.4.3-pre4
pcmcia-cs - 3.1.25 (also tried with 3.1.23)

Then I insert a card (I'm trying now with two cards: 3COM 3CCFE575CT,
D-Link DFE-680TX) the computer beeps and responds with:
"cs: socket XXXXX timed out during reset"


kernel config file is following:

#
# PCMCIA/CardBus support
#
CONFIG_PCMCIA=m
CONFIG_CARDBUS=y
CONFIG_I82365=y
CONFIG_TCIC=y
CONFIG_SYSVIPC=y
CONFIG_BSD_PROCESS_ACCT=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
# CONFIG_KCORE_AOUT is not set
CONFIG_BINFMT_AOUT=m
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
# CONFIG_ACPI is not set
CONFIG_APM=m
# CONFIG_APM_IGNORE_USER_SUSPEND is not set
# CONFIG_APM_DO_ENABLE is not set
# CONFIG_APM_CPU_IDLE is not set
# CONFIG_APM_DISPLAY_BLANK is not set
# CONFIG_APM_RTC_IS_GMT is not set
# CONFIG_APM_ALLOW_INTS is not set
# CONFIG_APM_REAL_MODE_POWER_OFF is not set           



I have found from the kernel-traffic list some information that it could
be because of wrong initalization of socket power (5V instead of 3.3V).

But how it could be solved? Is there any ready patch or know-how
available?


PS. The same computer works perfectly with RedHat6.2 - kernel 2.2.1X
(don't remember exact version).

Best wishes!
-- 
Mr. Anton Safonov   as@bestlinux.net  - tel.+372 56469626
SOT Finnish Software Engineering Ltd. - fax +372 6419975
Kreutzwaldi 7-4, 10124 TALLINN        - http://www.sot.com/
ESTONIA                               - http://bestlinux.net/
