Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318188AbSIJWRj>; Tue, 10 Sep 2002 18:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318182AbSIJWRj>; Tue, 10 Sep 2002 18:17:39 -0400
Received: from auscon.arc.nasa.gov ([143.232.69.76]:43905 "EHLO
	rudi.arc.nasa.gov") by vger.kernel.org with ESMTP
	id <S318188AbSIJWRf>; Tue, 10 Sep 2002 18:17:35 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Dan Christian <dchristian@mail.arc.nasa.gov>
Reply-To: dchristian@mail.arc.nasa.gov
Organization: NASA Ames Research Center
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 serial drops characters with 16654
Date: Tue, 10 Sep 2002 15:22:16 -0700
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200209101522.16321.dchristian@mail.arc.nasa.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've got a 2.4.18-10 (RedHat) running on a 2 processor Athlon (1.5Ghz).

If I send data over a PCI 16654 serial card (Connect Tech Blue Heat) and 
RTSCTS flow control is used, characters are dropped.  The drops are 
pretty consistent.  As far as I can tell, the data can only be lost in 
the driver (I'm re-trying the write until all the data gets out).

If I use a 16550, then everything is fine.  Unfortunely, I can't get rid 
of the 16654s.

If is use a 1 processor Athlon running 2.4.9-34 (RedHat), then 
everything is fine.

I haven't been about to test the 2.4.18 SMP system in single processor 
mode, because the IO-APIC goes nuts.  But that's another bug...

Anybody know why the serial driver is losing data?

I'm not on linux-kernel, so please reply directly.

-Dan
