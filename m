Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265316AbUAJTSs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 14:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265319AbUAJTSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 14:18:48 -0500
Received: from [202.28.93.1] ([202.28.93.1]:1034 "EHLO gear.kku.ac.th")
	by vger.kernel.org with ESMTP id S265316AbUAJTSp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 14:18:45 -0500
Date: Sun, 11 Jan 2004 02:18:25 +0700
From: Kitt Tientanopajai <kitt@gear.kku.ac.th>
To: linux-kernel@vger.kernel.org
Subject: 2.6 reports wrong CPU/Bus frequency
Message-Id: <20040111021825.797b25b3.kitt@gear.kku.ac.th>
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I have installed 2.6 kernel on my notebook and it seems that the kernel reports wrong CPU and bus frequency. My notebook is Acer TravelMate 361Evi, P-III Mobile CPU 1 GHz, and 133 MHz bus. The 2.6 kernel shows something like:

Jan 10 19:01:01 peorth kernel: Detected 1113.758 MHz processor.
...
Jan 10 19:01:01 peorth kernel: Calibrating delay loop... 1544.19 BogoMIPS
...
Jan 10 19:01:01 calibrating APIC timer ...
Jan 10 19:01:01 peorth kernel: ..... CPU clock speed is 1329.0639 MHz.
Jan 10 19:01:01 peorth kernel: ..... host bus clock speed is 177.0285 MHz.

For 2.4.x, they are:

Jan  9 14:29:00 peorth kernel: Detected 999.905 MHz processor.
...
Jan  9 14:29:00 peorth kernel: Calibrating delay loop... 1992.29 BogoMIPS
....
Jan  9 14:29:01 peorth kernel: calibrating APIC timer ...
Jan  9 14:29:01 peorth kernel: ..... CPU clock speed is 999.8676 MHz.
Jan  9 14:29:01 peorth kernel: ..... host bus clock speed is 133.3155 MHz.

I've tested this on 2.6.0-test11/2.6.0/2.6.1/2.6.1-mm1/2.6.1-mm2, none of them report the freq/bogomips near to those reported by 2.4.x. 

And, I'm not sure this is a related issue but, on 2.6 I got about 490 fps of glxgears, while I got about 600 fps on 2.4. hdparm -tT reports about the same for 2.4 and 2.6.

Any clue why 2.6 reports wrong freq ? Does this affect the performance/stability of the system, or else ? The system seems to run 2.6 without any other problems by the way.

Thanks in advance,
kitty
