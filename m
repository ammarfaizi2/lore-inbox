Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261549AbTCKTTL>; Tue, 11 Mar 2003 14:19:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261553AbTCKTTL>; Tue, 11 Mar 2003 14:19:11 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:9943 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S261549AbTCKTTJ>; Tue, 11 Mar 2003 14:19:09 -0500
Date: Tue, 11 Mar 2003 20:29:45 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@suse.de>, Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Would the real 82801E_9 please stand up. (fwd)
Message-ID: <20030311192945.GA16212@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The issue described in Dave's mail below is still present:

2.4.21-pre5-ac1:
#define PCI_DEVICE_ID_INTEL_82801E_9    0x2459
#define PCI_DEVICE_ID_INTEL_82801E_11   0x245B


2.5.64-ac3:
#define PCI_DEVICE_ID_INTEL_82801E_9    0x245b
#define PCI_DEVICE_ID_INTEL_82801E_11   PCI_DEVICE_ID_INTEL_82801E_9


Jens:
The patch that did the
  #define PCI_DEVICE_ID_INTEL_82801E_11   PCI_DEVICE_ID_INTEL_82801E_9
in 2.5 was sent by you, could you comment on this issue?

TIA
Adrian



----- Forwarded message from Dave Jones <davej@suse.de> -----

Date: Mon, 24 Jun 2002 23:58:52 +0200
From: Dave Jones <davej@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Would the real 82801E_9 please stand up.

Whilst syncing 2.4.19rc1, I spotted this problem
in pci_ids.h

2.4..

#define PCI_DEVICE_ID_INTEL_82801E_9    0x2459

2.5..

#define PCI_DEVICE_ID_INTEL_82801E_9    0x245b

In a word.. eughhh

        Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

