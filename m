Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264429AbTLGOAE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 09:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264433AbTLGOAD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 09:00:03 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:53508 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id S264429AbTLGOAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 09:00:00 -0500
Date: Sun, 7 Dec 2003 14:59:58 +0100 (CET)
From: Yuri van Oers <yvanoers@xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: flaw in lk 2.4.23 configure script(s)
Message-ID: <20031207132658.Q7853-100000@xs1.xs4all.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi:

There's an error in one or more linux 2.4 configure script concerning TSC.

Full description:
By default, the linux kernel is configured for Pentium-III (at least on my
system, I don't know if any automagical detection is done). This means
CONFIG_X86_TSC is (or will be) set. Changing to 486, then exiting
menuconfig does not remove CONFIG_X86_TSC! So after compiling a 486
kernel, then booting it on a 486 constitutes the following panic:
"Kernel compiled for Pentium+, requires TSC feature!".

This is easily worked around by making menuconfig, exiting, then saving
the kernel configuration. After this, CONFIG_X86_TSC is no longer
contained in .config .

I think there's a flaw in config.in, but I'll leave the pinpointing to
the appropriate maintainer.

Encountered this problem with 2.4.23 and 2.4.22. Have not tried other
versions.

Would be nice if corrected, IMHO :)

For any responses: please CC me, am not on the lkml.

Regards,
Yuri van Oers

