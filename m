Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262300AbTHTWxz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 18:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262294AbTHTWxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 18:53:54 -0400
Received: from Cambot.lecs.CS.UCLA.EDU ([131.179.144.110]:34316 "EHLO
	cambot.circlemud.org") by vger.kernel.org with ESMTP
	id S262300AbTHTWxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 18:53:53 -0400
Message-Id: <200308202253.h7KMrn116585@cambot.circlemud.org>
To: linux-kernel@vger.kernel.org
cc: jelson@circlemud.org, fusd-announce@lists.sourceforge.net
Subject: [ANNOUNCE] FUSD v1.10 now available
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <16583.1061420029.1@cambot.lecs.cs.ucla.edu>
Date: Wed, 20 Aug 2003 15:53:49 -0700
From: Jeremy Elson <jelson@circlemud.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We're happy to announce release 1.10 of FUSD, the Linux Framework for
User-Space Devices.

If you have a Linux 2.4 kernel running devfs, FUSD is a combination of
Linux kernel module and userspace library that lets you write
userspace programs that can act as character device drivers for files
under /dev.  Your program reigsters the device with the kernel module;
then, it proxies system calls (e.g.,  open(), read()...) to your
program.  Your userspace program can respond to these system calls as
a kernel module would.  Strict error checking at the user/kernel
boundary prevents such userspace drivers from corrupting each other,
the kernel, or even the processes using the devices they manage.

v1.10 has a number of enhancements, including:
  -- Now safe for SMP and preemptible kernels

  -- Includes both C and Python bindings

  -- /dev/fusd/status device shows a summary of devices registered and
     in use

  -- Updated documentation and various other bugfixes


Unfortunately, FUSD does NOT work under later 2.5 or any 2.6 kernels.
The recent changes to the devfs API break FUSD in a way that we
haven't yet looked into fixing.

Regards,
Jeremy
