Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbULZObB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbULZObB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 09:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbULZObB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 09:31:01 -0500
Received: from cimice4.lam.cz ([212.71.168.94]:7554 "EHLO beton.cybernet.src")
	by vger.kernel.org with ESMTP id S261654AbULZOaz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 09:30:55 -0500
Date: Sun, 26 Dec 2004 14:31:18 +0000
From: Karel Kulhavy <clock@twibright.com>
To: linux-kernel@vger.kernel.org
Subject: How to hang 2.6.9 using serial port and FB console
Message-ID: <20041226143118.GA5169@beton.cybernet.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Orientation: Gay
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

1) Obtain gentoo LiveCD 2004.3 which contains kernel 2.6.9-gentoo-r1
2) Obtain remote controller "YAMAHA REMOTE CONTROL TRANSMITTER RCX"
from "YAMAHA NATURAL SOUND STEREO RECEIVER RX-360 =RS"
3) Obtain an IrDA dongle based on datasheet circuit of HSDL3612
4) Obtain a motherboard with IrDA connector
5) Enable IrDA in BIOS, set up RX active Lo and TX active Hi and Full Duplex
(on my board, FIC VA503+ with 400MHz Athlon it was COM2 alias /dev/ttyS1)
6) Boot up the "gentoo" kernel from the LiveCD
7) Do stty -F /dev/ttyS1 ispeed 19200 ospeed 19200
8) Do hexdump /dev/ttyS1 on console 2 (those without the fancy graphics)
9) Press couple of keys on the remote control until the hexdump starts spewing
tons of characters continuously even when you don't press anything.
Switch to console 3 and back. Nothing happens.
10) Break the hexdump and run the cat again on console 1 (with fancy graphics)
11) Press keys on remote control until hexdump starts spewing chars continuously
12) Switch to console 3
13) Try to switch back to console 1. The system stops responding:
Action       Does user notice anything?
---------------------------------------
numlock      no
capslock     no
scrolllock   no
ctrl-alt-del no
alt-sysrq-a  no
alt-sysrq-u  no
alt-sysrq-b  reboot

The board used and the hardware in the PC is for a long time in usage and
don't have any observable problems.

Cl<
