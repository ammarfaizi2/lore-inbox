Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269010AbUJKONB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269010AbUJKONB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 10:13:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269008AbUJKONB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 10:13:01 -0400
Received: from i-r-genius.demon.co.uk ([80.177.6.225]:16001 "EHLO
	i-r-genius.com") by vger.kernel.org with ESMTP id S268979AbUJKOKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 10:10:45 -0400
From: "Tony Howat" <tony@i-r-genius.com>
To: linux-kernel@vger.kernel.org
Subject: Bit by bit parallel port  control
Date: Mon, 11 Oct 2004 15:10:13 +0100
Message-Id: <20041011141018.M62685@i-r-genius.com>
X-Mailer: Open WebMail 2.30 20040131
X-OriginatingIP: 192.168.1.1 (tony)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
X-i-r-genius.com-MailScanner-Information: Please contact the ISP for more information
X-i-r-genius.com-MailScanner: Found to be clean
X-MailScanner-From: tony@i-r-genius.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

I'm having problems controlling the parallel port on a bit-on bit-off basis 
for a relay switch on a control project.

Linux marmot 2.6.5-1.358 #1 Sat May 8 09:04:50 EDT 2004 i686 athlon i386 
GNU/Linux

I have tried using the /dev/port method and putb - I can seemingly set bits 
on the port OK. However, checking with a meter shows the line changing for a 
few milliseconds then returning to 0v. I need the levels to hold. I believe 
that's what SHOULD happen...

I figured the lp module may interfere, so removed that. No help. Currently 
lsmod shows:

w83781d                26240  0
i2c_sensor              2176  1 w83781d
i2c_amd756              4484  0
i2c_core               16388  3 w83781d,i2c_sensor,i2c_amd756
autofs4                10624  0
sunrpc                101064  1
forcedeth              10624  0
floppy                 47440  0
sg                     27552  0
scsi_mod               91344  1 sg
dm_mod                 33184  0
ati_remote              9228  0
ohci_hcd               14748  0
button                  4504  0
battery                 6924  0
asus_acpi               8472  0
ac                      3340  0
ext3                  102376  3
jbd                    40216  1 ext3

Board is an ASUS A72N266VM (nforce based). Build is fedora 2. I'm not 
running lpd or X etc. Any suggestions?

There's plenty of sample code around, so I'm pretty confident I'm doing 
things right. My test code is here :

http://www.i-r-genius.com/paralleltest.c

I suspect there's something odd going on. I aim to try the code on an older 
machine soon.

Any help or pointers appreciated,

--
Tony

