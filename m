Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262700AbTDQXm1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Apr 2003 19:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262701AbTDQXm1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Apr 2003 19:42:27 -0400
Received: from siaag1aa.compuserve.com ([149.174.40.3]:37875 "EHLO
	siaag1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262700AbTDQXm0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Apr 2003 19:42:26 -0400
Date: Thu, 17 Apr 2003 19:50:03 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: x86 IO-APIC and IRQ questions
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304171954_MC3-1-34E7-5FFD@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Why doesn't the timer IRQ have a higher priority on x86 IOAPIC
machines? Mine has interrupt vector 0x31, which is priority 3.
Shouldn't it be more like 0xe or 0xf?

 And why are the IRQ entry points (in 2.4.20) not 16-byte aligned?
Up until IRQ0x0b everything is OK because the actual stubs are only
7+1 bytes long, but after that the jmp instruction needs a 32-bit
offset and they are 10+2 bytes.  This puts IRQ #15 and #19 four
bytes from the end of a 16-byte cache line, and their first
instructions are 5 bytes long.


--
 Chuck
