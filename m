Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261500AbTLCUpV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbTLCUpV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:45:21 -0500
Received: from aples1.dom1.jhuapl.edu ([128.244.26.85]:4626 "EHLO
	aples1.jhuapl.edu") by vger.kernel.org with ESMTP id S261500AbTLCUov convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:44:51 -0500
Message-ID: <E37E01957949D611A4C30008C7E691E20915BBC3@aples3.dom1.jhuapl.edu>
From: "Collins, Bernard F. (Skip)" <Bernard.Collins@jhuapl.edu>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Visor USB hang
Date: Wed, 3 Dec 2003 15:44:47 -0500 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.4.23 on a RedHat 9 system. Whenever I try to sync my Visor
Deluxe, the system hangs/freezes soon after I press the sync button on my
cradle. Trying to find the cause of the problem, I preloaded the usbserial
and visor modules with "debug=1". Nothing obviously wrong appears in the
logs. The last message before the system freezes is a usb-uhci.c interrupt
message. Any help debugging this further would be appreciated. Please CC me
on any replies.

Here are the relevant lines from /var/log/messages:
Dec  3 15:19:20 xtr45wac kernel: usb.c: registered new driver serial
Dec  3 15:19:20 xtr45wac kernel: usbserial.c: USB Serial support registered
for Generic
Dec  3 15:19:20 xtr45wac kernel: usbserial.c: USB Serial Driver core v1.4
Dec  3 15:19:27 xtr45wac kernel: usbserial.c: USB Serial support registered
for Handspring Visor / Treo / Palm 4.0 / Clié4.x
Dec  3 15:19:28 xtr45wac kernel: usbserial.c: USB Serial support registered
for Sony Clié3.5
Dec  3 15:19:28 xtr45wac kernel: visor.c: USB HandSpring Visor, Palm m50x,
Treo, Sony Cliédriver v1.7
Dec  3 15:20:35 xtr45wac kernel: hub.c: new USB device 00:1d.1-2, assigned
address 3
Dec  3 15:20:35 xtr45wac kernel: usbserial.c: Handspring Visor / Treo / Palm
4.0 / Clié4.x converter detected
Dec  3 15:20:35 xtr45wac kernel: visor.c: Handspring Visor / Treo / Palm 4.0
/ Clié4.x: Number of ports: 2
Dec  3 15:20:35 xtr45wac kernel: visor.c: Handspring Visor / Treo / Palm 4.0
/ Clié4.x: port 1, is for Generic use and is bound to ttyUSB0
Dec  3 15:20:35 xtr45wac kernel: visor.c: Handspring Visor / Treo / Palm 4.0
/ Clié4.x: port 2, is for HotSync use and is bound to ttyUSB1
Dec  3 15:20:35 xtr45wac kernel: usbserial.c: Handspring Visor / Treo / Palm
4.0 / Clié4.x converter now attached to ttyUSB0 (or usb/tts/0 for devfs)
Dec  3 15:20:35 xtr45wac kernel: usbserial.c: Handspring Visor / Treo / Palm
4.0 / Clié4.x converter now attached to ttyUSB1 (or usb/tts/1 for devfs)
Dec  3 15:20:36 xtr45wac kernel: usb-uhci.c: interrupt, status 2, frame#
1499
Dec  3 15:21:58 xtr45wac syslogd 1.4.1: restart.
D
