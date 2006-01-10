Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932536AbWAJTzn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932536AbWAJTzn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932551AbWAJTzn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:55:43 -0500
Received: from mx.pathscale.com ([64.160.42.68]:55722 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932544AbWAJTzm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:55:42 -0500
Content-Type: multipart/mixed; boundary="===============0050496122=="
MIME-Version: 1.0
Subject: [PATCH 0 of 3] 32-bit MMIO copy routines, reworked
Message-Id: <patchbomb.1136922836@serpentine.internal.keyresearch.com>
Date: Tue, 10 Jan 2006 11:53:56 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, ak@suse.de,
       rdreier@cisco.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============0050496122==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

After some more review comments from Roland, Andrew and Chris Hellwig,
here is a reworked set of 32-bit MMIO copy patches.

These use CONFIG_RAW_MEMCPY_IO to determine whether an arch should use
the generic __raw_memcpy_toio32 routine or its own specialised version.
We provide a specialised implementation for x86_64.

These patches should apply cleanly against current -git, and have been
tested on i386 and x86_64.

The patch series is as follows:

raw_memcpy_io.patch
  Introduce the generic MMIO 32-bit copy routine.

x86_64-memcpy32.patch
  Add memcpy32 routine to x86_64.

arch-specific-raw_memcpy_io.patch
  Get each arch to use generic memcpy_io code, except x86_64, which
  uses memcpy32.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

--===============0050496122==--
