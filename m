Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264031AbRFSKTj>; Tue, 19 Jun 2001 06:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264108AbRFSKT3>; Tue, 19 Jun 2001 06:19:29 -0400
Received: from f00f.stub.clear.net.nz ([203.167.224.51]:63241 "HELO
	metastasis.f00f.org") by vger.kernel.org with SMTP
	id <S264031AbRFSKTU>; Tue, 19 Jun 2001 06:19:20 -0400
Date: Tue, 19 Jun 2001 22:19:16 +1200
From: Chris Wedgwood <cw@f00f.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: serial console -- busted under 2.4.6 and thereabouts?
Message-ID: <20010619221915.A17447@metastasis.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get serial console working under 2.4.6-pre3; I see
previous messages about the CREAD 'bug' but I'm pretty sure I am
seeing something else.

Basically, the serial port works with lilo, and with getty once the
system is booted, but I don't get any kernel messages on the console
and serial-SysRq doesn't work.

If I go back to a 2.4.3 (or maybe 2.4.2-pre? kernel) I build some
months ago (hence why I am unsure of the exact version) it works as
expected.

Diffing I see no kernel/printk.c changes, and the only
drivers/char/serial.c changes I see don't explain my problem.

At first, I thouht it might be divider problem or failing to set the
bit-rate, as I use 38400, but if I change to 9600 when I
_should_ get kernel messages (after lilo says booting kernel), I can
actually see them... but as to why to why this is the case I'm lost.

I have tried drivers/char/serial.c from 2.4.3 in 2.4.6-pre3 and that
doesn't work either.

Suggestion anyone?




    --cw
