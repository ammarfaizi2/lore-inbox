Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261873AbUKCUra@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261873AbUKCUra (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 15:47:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261869AbUKCUpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 15:45:50 -0500
Received: from hal-5.inet.it ([213.92.5.24]:58350 "EHLO hal-5.inet.it")
	by vger.kernel.org with ESMTP id S261876AbUKCUnx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 15:43:53 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Test patch for ub and double registration
Date: Wed, 3 Nov 2004 21:43:01 +0100
User-Agent: KMail/1.7.1
Cc: linux-kernel@vger.kernel.org, cs@tequila.co.jp
References: <20041101164432.3fa72b81@lembas.zaitcev.lan> <200411022257.24752.cova@ferrara.linux.it> <20041102151044.4270bc12@lembas.zaitcev.lan>
In-Reply-To: <20041102151044.4270bc12@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411032143.02197.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 00:10, mercoledì 03 novembre 2004, Pete Zaitcev ha scritto:

> I'd like to secure one last favour from you. Please do this for me:
> 1. Connect the thing
> 2. Run
> find /sys -name diag | xargs cat | mail -s "Flavio's ub diag"
> zaitcev@redhat.com

uhm.. maybe the mail was not so interesting.. :)

[root@kefk root]# find /sys -name diag | xargs cat | mail -s "Flavio's ub 
diag" zaitcev@redhat.com
find: /sys/devices/system/timer: No such file or directory
Null message body; hope that's ok

After inserting the device, I've got this:
============
Nov  3 21:36:25 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov  3 21:36:25 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov  3 21:36:25 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov  3 21:36:25 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov  3 21:36:25 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov  3 21:36:25 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 8
Nov  3 21:36:25 kefk kernel: ehci_hcd 0000:00:1d.7: devpath 3 ep0in 3strikes
Nov  3 21:36:26 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 full speed --> 
companion
Nov  3 21:36:26 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
003801 POWER OWNER sig=j  CONNECT
Nov  3 21:36:26 kefk kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
Nov  3 21:36:26 kefk kernel: uhci_hcd 0000:00:1d.1: port 1 portsc 0083,00
Nov  3 21:36:26 kefk kernel: hub 2-0:1.0: port 1, status 0101, change 0001, 12 
Mb/s
Nov  3 21:36:26 kefk kernel: hub 2-0:1.0: debounce: port 1: total 100ms stable 
100ms status 0x101
Nov  3 21:36:26 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
and address 4
Nov  3 21:36:26 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov  3 21:36:26 kefk kernel: [f7a6c240] link (37a6c1b2) element (37a6b040)
Nov  3 21:36:26 kefk kernel:   0: [f7a6b040] link (37a6b080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=37c882a0)
Nov  3 21:36:26 kefk kernel:   1: [f7a6b080] link (37a6b0c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=1cd988c0)
Nov  3 21:36:26 kefk kernel:   2: [f7a6b0c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov  3 21:36:26 kefk kernel:
Nov  3 21:36:26 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov  3 21:36:26 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov  3 21:36:26 kefk kernel: [f7a6c240] link (37a6c1b2) element (37a6b040)
Nov  3 21:36:26 kefk kernel:   0: [f7a6b040] link (37a6b080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=377657c0)
Nov  3 21:36:26 kefk kernel:   1: [f7a6b080] link (37a6b0c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=1cd988c0)
Nov  3 21:36:26 kefk kernel:   2: [f7a6b0c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov  3 21:36:26 kefk kernel:
Nov  3 21:36:26 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov  3 21:36:27 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
and address 5
Nov  3 21:36:27 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov  3 21:36:27 kefk kernel: [f7a6c240] link (37a6c1b2) element (37a6b040)
Nov  3 21:36:27 kefk kernel:   0: [f7a6b040] link (37a6b080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=377657c0)
Nov  3 21:36:27 kefk kernel:   1: [f7a6b080] link (37a6b0c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=1cd988c0)
Nov  3 21:36:27 kefk kernel:   2: [f7a6b0c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov  3 21:36:27 kefk kernel:
Nov  3 21:36:27 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov  3 21:36:27 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov  3 21:36:27 kefk kernel: [f7a6c240] link (37a6c1b2) element (37a6b040)
Nov  3 21:36:27 kefk kernel:   0: [f7a6b040] link (37a6b080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=377657c0)
Nov  3 21:36:27 kefk kernel:   1: [f7a6b080] link (37a6b0c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=1cd988c0)
Nov  3 21:36:27 kefk kernel:   2: [f7a6b0c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov  3 21:36:27 kefk kernel:
Nov  3 21:36:27 kefk kernel: usb 2-1: device descriptor read/64, error -71
=================

But I don't know why now usb 2-1 device is called (the machine is in the same 
state of last try, no reboots).




-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
