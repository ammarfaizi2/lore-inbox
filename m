Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbUBYVSV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261596AbUBYVQu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:16:50 -0500
Received: from catv2171.extern.kun.nl ([131.174.122.171]:24771 "EHLO
	phiwumbda.localnet") by vger.kernel.org with ESMTP id S261554AbUBYVQJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 16:16:09 -0500
To: linux-kernel@vger.kernel.org
Subject: ACPI and semaphore headaches with intel8x0 soundcard
From: jesse@phiwumbda.org (Jesse F. Hughes)
Organization: The International Eternal Order of Palsy-Walsies
Content-Type: text/plain; charset=US-ASCII
Date: Wed, 25 Feb 2004 22:22:31 +0100
Message-ID: <87u11eam7c.fsf@phiwumbda.org>
User-Agent: Gnus/5.090017 (Oort Gnus v0.17) XEmacs/21.4 (Reasonable
 Discussion, linux)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey ho.

I have been having problems with my intel8x0 soundcard on my NEC Versa
P520 laptop for some time now, and I think that the problems began
when I upgraded the BIOS for this thing.  (I also upgraded from
Slackware 9.0 to 9.1 around the same time, but I think that's
irrelevant.)

Every so often, when I boot, I get the following error message.

syslog.1:Feb 16 15:32:52 euclid kernel: ALSA /usr/src/sound/alsa-driver-1.0.2c/pci/intel8x0.c:1969: AC'97 warm reset still in progress? [0x6]

Most of the time, the card is fine on bootup, but at some time, the
card sputters a bit and then just gives up, with the following error.

Feb 25 17:19:50 euclid kernel: ALSA sound/pci/intel8x0.c:591: codec_write 0: semaphore is not ready for register 0x2c
Feb 25 17:19:50 euclid kernel: ALSA sound/pci/intel8x0.c:607: codec_read 0: semaphore is not ready for register 0x2c

In both cases, I can't get the card to work without a reboot.

Jaroslav Kysela on alsa-user suggested the problem may be ACPI-related
and that I should check here.  Today, I noticed that the semaphore bug
occurred exactly as I was shutting the lid on my laptop, which I think
adds some support to his diagnosis.  But I don't know diddly about
ACPI (in fact, what little I know I learned today -- had no idea about
these features).  I'll need help knowing what to do from here.

While trying to fix the problem, I've upgraded to the 2.6.3 kernel.
I'm not really sure what's relevant here.  I have acpi support in the
kernel, with power, ac, button, thermal, processor, fan and battery
modules loaded at boot time (actually, before today, none of those
modules were loaded).

Should I try moving to APM instead of ACPI?  Is that likely to help?
I hate to give up the cool features I read about today.

At this point it is doubtful that I can roll back the BIOS upgrade.

Thanks for your time.  Please let me know what information I've
omitted.

-- 
Jesse F. Hughes 
"Radicals are interesting because they were considered 'radical' by
the people who played with them who wrote a lot of math work that
modern mathematics depends on." --Another JSH history lesson
