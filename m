Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266276AbUBLEo4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 23:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266277AbUBLEo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 23:44:56 -0500
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:10165 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S266276AbUBLEoy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 23:44:54 -0500
Message-ID: <402B04C1.10400@blue-labs.org>
Date: Wed, 11 Feb 2004 23:44:49 -0500
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040121
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: ALSA, 2.6.3-rc2, wrong interrupt acknowledge, max jitter, intel8x0,
 AC97
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Feb 11 23:34:44 Huntington-Beach ALSA sound/core/pcm_lib.c:233: 
Unexpected hw_pointer value [2] (stream = 0, delta: -550, max jitter = 
1392): wrong interrupt acknowledge?
Feb 11 23:34:44 Huntington-Beach ALSA sound/core/pcm_lib.c:233: 
Unexpected hw_pointer value [2] (stream = 0, delta: -552, max jitter = 
1392): wrong interrupt acknowledge?

# grep -c "max jitter" /var/log/messages
52539

The system has only been up and running for a few minutes and the only 
sound that has been played is the startup audio for KDE, and a couple of 
popup sounds.

artsd is running at 29% cpu and has eaten two minutes of cpu time with 
the uptime of 14 minutes.

intel8x0_measure_ac97_clock: measured 49366 usecs
intel8x0: clocking to 47391
ALSA sound/pci/intel8x0.c:2781: joystick(s) found
ALSA device list:
  #0: NVidia nForce2 at 0xee080000, irq 193

