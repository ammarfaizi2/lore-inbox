Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263967AbTDWMRf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 08:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263968AbTDWMRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 08:17:35 -0400
Received: from web14002.mail.yahoo.com ([216.136.175.93]:44154 "HELO
	web14002.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263967AbTDWMRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 08:17:33 -0400
Message-ID: <20030423122940.51011.qmail@web14002.mail.yahoo.com>
Date: Wed, 23 Apr 2003 05:29:40 -0700 (PDT)
From: Tony Spinillo <tspinillo@yahoo.com>
Subject: IEEE-1394 problem on init [ was Re: Linux 2.4.21-rc1 ]
To: linux-kernel@vger.kernel.org
Cc: stelian.pop@fr.alcove.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian

Similiar problem here. Machine boots fine, but when I plug my DV
camera in I can't cat /proc/bus/ieee1394/ devices, and I get looping
messages in dmesg. If I move the 1394 drivers from pre-7 in, all works
fine.
(Thanks Dan). I submitted my logs and hw info to:
http://sourceforge.net/mailarchive/forum.php?thread_id=2009188&forum_id=5387

Tony

>Something gone wrong with this changes. My Sony Vaio Picturebook C1VE
>hangs on boot when the firewire controller is probed by the init
>scripts.

>This happens exactly in the sequence:
>	modprobe ohci1394
>	grep something /proc/bus/ieee1394/devices
>I'm not sure yet if the lockup is related to the ohci1394
initialisation
>or the read in /proc possibly eariler than the driver expects.
>
>The kernel still reacts to sysrq (umount/sync etc), however
task/memory/pc
>sysrq function do NOT work...
>
>I'll investigate a bit further on this today.
