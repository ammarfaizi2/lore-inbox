Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264116AbTIIOOa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 10:14:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264171AbTIIOOa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 10:14:30 -0400
Received: from mta06-svc.ntlworld.com ([62.253.162.46]:44276 "EHLO
	mta06-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S264116AbTIIOO2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 10:14:28 -0400
Subject: Audio skipping with alsa
From: Russ Garrett <rg@tcslon.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1063116861.852.50.camel@russell>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 09 Sep 2003 15:14:21 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I've just installed an M-Audio Audiophile 2496 sound card (Envy24)
with the 2.6.0-test5 kernel (with the preemptible kernel option on),
using the ice1712 alsa driver (although this also happens in 2.4.21
without preemptible kernel).

Music plays fine until I do *anything* - changing windows, scrolling,
pressing buttons, whatever - when it stutters badly. Scrolling in an
anti-aliased terminal is especially fun. However, if I play using XMMS
with the realtime priority option, everything's fine, although that has
the distinct disadvantage that I have to run it as root.

I've tried enabling/disabling ACPI/APM/APIC. The card isn't sharing an
IRQ with anything.  It's not a hard drive/IDE related issue, although
that's all using DMA anyway. 

I do have both an AGP and a PCI graphics card installed and in use,
although the stuttering happens if I do anything on either. I've found a
few references to this problem on google, but no solutions. It works
fine on Windows ;).

Here's what happens if I try to scroll in gnome-terminal whilst aplaying
something:

rg@russell:~$ aplay < test
Playing raw data 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
xrun!!! (at least 869.990 ms long)
xrun!!! (at least 21.552 ms long)
xrun!!! (at least 17.686 ms long)
xrun!!! (at least 16.482 ms long)
xrun!!! (at least 17.194 ms long)
xrun!!! (at least 17.126 ms long)
xrun!!! (at least 14.123 ms long)
xrun!!! (at least 13.679 ms long)
xrun!!! (at least 12.928 ms long)
[...and so on, for another 20 or so lines]

lspci says:

00:0c.0 Multimedia audio controller: IC Ensemble Inc ICE1712 [Envy24]
(rev 02)
        Subsystem: IC Ensemble Inc: Unknown device d634
        Flags: bus master, medium devsel, latency 32, IRQ 12
        I/O ports at d400 [size=32]
        I/O ports at d800 [size=16]
        I/O ports at dc00 [size=16]
        I/O ports at e000 [size=64]
        Capabilities: [80] Power Management version 1



-- 
Russ Garrett		http://russ.garrett.co.uk
russ@garrett.co.uk

