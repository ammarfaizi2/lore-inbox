Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265381AbTFFHh3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 03:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265383AbTFFHh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 03:37:29 -0400
Received: from gherkin.frus.com ([192.158.254.49]:384 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id S265381AbTFFHh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 03:37:28 -0400
Subject: 2.5.70: AXIS usb flash disk problem
To: linux-kernel@vger.kernel.org
Date: Fri, 6 Jun 2003 02:51:00 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030606075100.B35774F0C@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob Tracy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well...  *That* was exciting :-(.  I plugged a 64 MB AXIS usb flash
disk into my Linux machine, and the following syslog messages were
recorded before the machine locked up solid:

Jun  6 02:20:32 gherkin kernel: Initializing USB Mass Storage driver...
Jun  6 02:20:33 gherkin kernel: scsi1 : SCSI emulation for USB Mass Storage devices
Jun  6 02:20:33 gherkin kernel:   Vendor: STORIX    Model: AXIS              Rev: 1.00
Jun  6 02:20:33 gherkin kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
Jun  6 02:20:33 gherkin kernel: SCSI device sdb: 128000 512-byte hdwr sectors (66 MB)
Jun  6 02:20:33 gherkin kernel: usb-storage: Buffer length smaller than header!!<4>usb-storage: Had to truncate MODE_SENSE_10 buffer into MODE_SENSE.
Jun  6 02:20:33 gherkin kernel: usb-storage: outputBufferSize is 10 and length is 4.
Jun  6 02:20:33 gherkin kernel: usb-storage: Command will be truncated to fit in SENSE6 buffer.
Jun  6 02:20:33 gherkin kernel: sdb: Write Protect is off
Jun  6 02:20:33 gherkin kernel: sdb: Mode Sense: 00 00 00 00
Jun  6 02:20:33 gherkin kernel: usb-storage: Buffer length smaller than header!!<4>usb-storage: Command will be truncated to fit in SENSE6 buffer.
Jun  6 02:20:33 gherkin kernel: usb-storage: Buffer length smaller than header!!<4>usb-storage: Had to truncate MODE_SENSE_10 buffer into MODE_SENSE.
Jun  6 02:20:33 gherkin kernel: usb-storage: outputBufferSize is 4 and length is 1.
Jun  6 02:20:33 gherkin kernel: usb-storage: Command will be truncated to fit in SENSE6 buffer.

Any reason why SCSI emulation and the real thing might not get along?
The scsi0 device is an Adaptec 2930U2 (aic7xxx driver).  Haven't tried
using the usb flash disk on a Linux IDE machine yet.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
