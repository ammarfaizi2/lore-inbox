Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311650AbSDEFgd>; Fri, 5 Apr 2002 00:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311786AbSDEFgY>; Fri, 5 Apr 2002 00:36:24 -0500
Received: from bitsorcery.com ([161.58.175.48]:60942 "EHLO bitsorcery.com")
	by vger.kernel.org with ESMTP id <S311650AbSDEFgR>;
	Fri, 5 Apr 2002 00:36:17 -0500
From: Albert Max Lai <amlai@bitsorcery.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15533.14286.502083.225297@bitsorcery.com>
Date: Fri, 5 Apr 2002 05:36:14 +0000
To: linux-kernel@vger.kernel.org
Subject: 2.4.x and DAC960 issues
X-Mailer: VM 7.01 under Emacs 20.4.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have had problems using the DAC960 driver under any 2.4.x kernel
(currently using 2.4.18).  I have not experienced these problems under
2.2.x.

1.  Under reasonably low loads the driver will hang.  It is very
    reproducible when using the benchmark program "Bonnie."  This
    problem is exacerbated when using the ext3 filing system, locking
    up almost immediately.

2.  I am not sure if this is related, but I believe that it is.  I see
    the message "spurious 8259A interrupt: IRQ7."  Most of the
    examples of this that I have read about involve having APIC
    enabled.  But, for me, this is not the case.

3.  If I boot without appending the "noapic" option, the driver hangs
    after scanning the bus for cards, but before getting to
    configuring the card.  This is minor.  I can live with this
    workaround.

The machine is a Tyan S1836DLUAN-BX, dual PIII 600Mhz.  The controller
is a DAC1164P w/ Firmware Version: 5.08-0-87.  The problem exists with
prior versions of the firmware and either RAID 0 or RAID 5 setups.
Kernels are compiled w/ egcs-2.91.66.

Please let me know if any additional information is needed.  Any help
debugging these problems would be appreciated.  Thanks in advance.

-Albert
