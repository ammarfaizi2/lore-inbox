Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267484AbRGTXym>; Fri, 20 Jul 2001 19:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267485AbRGTXyW>; Fri, 20 Jul 2001 19:54:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48514 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267484AbRGTXyP>;
	Fri, 20 Jul 2001 19:54:15 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15192.50343.391453.974801@pizda.ninka.net>
Date: Fri, 20 Jul 2001 16:54:15 -0700 (PDT)
To: "Raj, Ashok" <ashok.raj@intel.com>
Cc: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: pci resource mapping problem for PCI-X mode
In-Reply-To: <9319DDF797C4D211AC4700A0C96B7C9404AC2124@orsmsx42.jf.intel.com>
In-Reply-To: <9319DDF797C4D211AC4700A0C96B7C9404AC2124@orsmsx42.jf.intel.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Raj, Ashok writes:
 > it works for now, since the addr msb's are 0. but if this physical addr is a
 > true 64bit addr
 > the above wont work..

On a 32-bit system, the BIOS (nor the kernel) will never assign a
resource to the device with the upper 32-bits non-zero.

This is also done for compatability reasons, so that PCI devices which
may only perform SAC transactions (ie. no dual-address cycle
capability) may do PCI peer-to-peer DMA to/from devices even when
using 64-bit BARs.

To be honest, 64-bit BARs are pretty useless today, being that %99 of
PCI controllers do not even provide a way for the cpu to address the
PCI memory space above 4GB.  This is true even on 64-bit CPU systems.

In short there are no problems.

Later,
David S. Miller
davem@redhat.com

