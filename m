Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261573AbSLCPem>; Tue, 3 Dec 2002 10:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSLCPem>; Tue, 3 Dec 2002 10:34:42 -0500
Received: from rtlab.med.cornell.edu ([140.251.145.175]:29369 "HELO
	openlab.rtlab.org") by vger.kernel.org with SMTP id <S261573AbSLCPem>;
	Tue, 3 Dec 2002 10:34:42 -0500
Date: Tue, 3 Dec 2002 10:42:13 -0500 (EST)
From: "Calin A. Culianu" <calin@ajvar.org>
X-X-Sender: <calin@rtlab.med.cornell.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: SMP Pentium4 -- PAUSE Instruction
Message-ID: <Pine.LNX.4.33L2.0212031029580.1780-100000@rtlab.med.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I as wondering -- according to Intel's docs they recommend that on a P4
processor to use the PAUSE instruction (aka rep followed by a nop) inside
any spin loop (such as one used in SMP spinlock code) in order to both
improve processor performance and reduce power consumption.

Is this instruction being used in spin-wait loops?  For some reason, I am
having a hard time figuring out whether or not it is being used.  There is
a rep_nop() in processor.h.. but I can't determine if that is being called
for spin lock lock/unlock code.


-Calin


