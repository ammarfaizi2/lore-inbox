Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265586AbTFMXxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 19:53:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265588AbTFMXxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 19:53:32 -0400
Received: from dp.samba.org ([66.70.73.150]:48602 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S265586AbTFMXxb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 19:53:31 -0400
Date: Sat, 14 Jun 2003 10:03:42 +1000
From: Anton Blanchard <anton@samba.org>
To: "Feldman, Scott" <scott.feldman@intel.com>
Cc: "David S. Miller" <davem@redhat.com>, haveblue@us.ibm.com,
       hdierks@us.ibm.com, dwg@au1.ibm.com, linux-kernel@vger.kernel.org,
       milliner@us.ibm.com, ricardoz@us.ibm.com, twichell@us.ibm.com,
       netdev@oss.sgi.com
Subject: Re: e1000 performance hack for ppc64 (Power4)
Message-ID: <20030614000342.GE32097@krispykreme>
References: <C6F5CF431189FA4CBAEC9E7DD5441E010107D93A@orsmsx402.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6F5CF431189FA4CBAEC9E7DD5441E010107D93A@orsmsx402.jf.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> I thought the answer was no, so I double checked with a couple of
> hardware guys, and the answer is still no.

Hi Scott,

Thats a pity, the e100 docs on sourceforge show it can do what we want,
it would be nice if e1000 had this feature too :)

4.2.2 Read Align

The Read Align feature is aimed to enhance performance in cache line
oriented systems. Starting a PCI transaction in these systems on a
non-cache line aligned address may result in low  performance. To solve
this performance problem, the controller can be configured to terminate
Transmit DMA cycles on a cache line boundary, and start the next
transaction on a cache line aligned address. This  feature is enabled
when the Read Align Enable bit is set in device Configure command
(Section 6.4.2.3, "Configure (010b)").

If this bit is set, the device operates as follows:

* When the device is close to running out of resources on the Transmit
* DMA (in other words, the Transmit FIFO is almost full), it attempts to
* terminate the read transaction on the nearest cache line boundary when 
* possible.

* When the arbitration counters feature is enabled (maximum Transmit DMA
* byte count value is set in configuration space), the device switches
* to other pending DMAs on cache line boundary only.
