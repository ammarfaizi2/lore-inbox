Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265311AbTLRT6n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 14:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265316AbTLRT6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 14:58:43 -0500
Received: from outmail.nrtc.org ([204.145.144.17]:38684 "EHLO
	exchange.nrtc.coop") by vger.kernel.org with ESMTP id S265311AbTLRT6k convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 14:58:40 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.6944.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: 2.4.23 is freezing my systems hard after 24-48 hours
Date: Thu, 18 Dec 2003 14:58:39 -0500
Message-ID: <F7F4B5EA9EBD414D8A0091E80389450569D3F6@exchange.nrtc.coop>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 2.4.23 is freezing my systems hard after 24-48 hours
Thread-Index: AcPD8PaD4wYIyPpJQ0ubJWJnzA18ngBsDbyw
From: "Jeremy Kusnetz" <JKusnetz@nrtc.org>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Please try the NMI oopser.

Okay, the box just crashed.  It's acting differently then the previous crashes.  The previous crashed would lock up hard, no network, no output to screen, no sysrq.  I don't know if the NMI-watchdog is what's letting it get this far.

This is the output to screen:

BUG IN DYNAMIC LINKER ld.so: ../sysdeps/i386/dl-machine.h: 391: elf_machine_lazy_rel: Assertion `((reloc->r_info) & 0xff) == 7' failed!

It just streams this error over and over on the console, and you also get this message back if you attempt to ssh to the box.

Again, I don't know if this is the same thing that was happening before, but all my other boxes that are running 2.4.22 have been doing so without any issue for about 5 days now, this one died after 50 hours.

Also I was getting this in syslog:

Dec 17 11:26:27 realserver6 inetd[92]: pid 4152: exit status 127
 Dec 17 11:26:48 realserver6 inetd[92]: pid 4217: exit status 127
 Dec 17 11:27:27 realserver6 inetd[92]: pid 4375: exit status 127
 Dec 17 11:27:48 realserver6 inetd[92]: pid 4450: exit status 127
 Dec 17 11:27:49 realserver6 inetd[92]: pid 4462: exit status 127
 Dec 17 11:27:52 realserver6 init: Id "c1" respawning too fast: disabled for 5 minutes
 Dec 17 11:27:52 realserver6 inetd[92]: pid 4480: exit status 127
 Dec 17 11:27:52 realserver6 inetd[92]: pid 4481: exit status 127
 Dec 17 11:28:27 realserver6 inetd[92]: pid 4591: exit status 127


Again I've never seen this with other kernels, yet everything else the same.
