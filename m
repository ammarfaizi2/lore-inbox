Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUCKDVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 22:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262980AbUCKDVc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 22:21:32 -0500
Received: from fw.osdl.org ([65.172.181.6]:12238 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262974AbUCKDVY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 22:21:24 -0500
Date: Wed, 10 Mar 2004 19:28:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Linux 2.6.4
Message-ID: <Pine.LNX.4.58.0403101924510.3693@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


A few small fixes since -rc3, most notably an OHCI bug that would corrupt
memory and seems to have been the reason for the "Bad page flags" bug at
least on ppc64 (it's not been reported on x86, as far as I know, but I
don't see why the corruption couldn't have happened there too).

The full changelog from 2.6.3 is on the ftp-sites along with the patches
and tar-balls, and the BK trees have been updated.

			Linus

---

Summary of changes from v2.6.4-rc3 to v2.6.4
============================================

Andrew Morton:
  o tty oops fix

Anton Blanchard:
  o ppc64 POWER3 segment table fix

Benjamin Herrenschmidt:
  o Fix PCI<->OF matching on G5 AGP bus
  o ppc64: Fix occasional crash at boot in OF interface
  o ppc64: Let OF initialize all displays in the system
  o Fix lockup accessing config space on G5

David Brownell:
  o USB: fix OHCI list corruption
  o Proper OHCI unlink fix

Don Fry:
  o pcnet32.c oops

Gerd Knorr:
  o bttv input update

Jens Axboe:
  o set request fastfail bit correctly

Krishna Kumar:
  o [IPV4/IPV6]: Add missing kmalloc failure checks

Linus Torvalds:
  o Make sure to include syscalls.h to get proper prototypes
  o Remove 'const' from min/max, to avoid gcc warning about double
    usage
  o Make bad_page() print out information about who triggered it
  o Revert 8259 timer ack workaround
  o Make bad_page() print out the page address
  o Linux 2.6.4

Olaf Kirch:
  o [IPV6]: Do not report {multi,any}cast in inet6_dump_ifaddr()

Petr Vandrovec:
  o ncpfs fails to correctly retry requests on timeout

Richard Henderson:
  o [ALPHA] Mark exit_code before waking process for SINGLESTEP
  o [ALPHA] Fix compressed bootp
  o [ALPHA] Fix gcc 3.4 build problems
  o [ALPHA] Add stat64 syscalls

