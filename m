Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318971AbSIKOYF>; Wed, 11 Sep 2002 10:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319041AbSIKOYF>; Wed, 11 Sep 2002 10:24:05 -0400
Received: from adsl-67-120-62-187.dsl.lsan03.pacbell.net ([67.120.62.187]:62730
	"EHLO exchange.macrolink.com") by vger.kernel.org with ESMTP
	id <S318971AbSIKOYE>; Wed, 11 Sep 2002 10:24:04 -0400
Message-ID: <11E89240C407D311958800A0C9ACF7D13A7992@EXCHANGE>
From: Ed Vance <EdV@macrolink.com>
To: "'dchristian@mail.arc.nasa.gov'" <dchristian@mail.arc.nasa.gov>
Cc: linux-kernel@vger.kernel.org
Subject: RE: 2.4.18 serial drops characters with 16654
Date: Wed, 11 Sep 2002 07:28:45 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, September 10, 2002 at 3:22 PM, Dan Christian wrote:
> I've got a 2.4.18-10 (RedHat) running on a 2 processor Athlon (1.5Ghz).
> If I send data over a PCI 16654 serial card (Connect Tech Blue Heat) and 
> RTSCTS flow control is used, characters are dropped.  The drops are 
> pretty consistent.  As far as I can tell, the data can only be lost in 
> the driver (I'm re-trying the write until all the data gets out).
> 
> If I use a 16550, then everything is fine.  Unfortunately, I can't get 
> rid of the 16654s.
> 
> If is use a 1 processor Athlon running 2.4.9-34 (RedHat), then 
> everything is fine.
> 
> I haven't been about to test the 2.4.18 SMP system in single processor 
> mode, because the IO-APIC goes nuts.  But that's another bug...
> 
> Anybody know why the serial driver is losing data?
> 
> I'm not on linux-kernel, so please reply directly.

Hi Dan,

We use Exar ST16C654D chips on a cPCI 16-port mux we build and have not
(yet) had a problem report on it for this. Maybe I can reproduce the symptom
on this board. What vendor marking is on your UARTs? Could you tell me more
about your test setup and specifically how often data is dropped and how
many characters are dropped each time? What kind of device is receiving the
data and how much receive FIFO does it have left when it drops RTS to tell
the Blue Heat to stop? 

Best regards,
Ed

---------------------------------------------------------------- 
Ed Vance              serial24 (at) macrolink (dot) com
Macrolink, Inc.       1500 N. Kellogg Dr  Anaheim, CA  92807
----------------------------------------------------------------

