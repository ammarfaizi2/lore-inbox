Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWAKWl2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWAKWl2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWAKWl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:41:28 -0500
Received: from mx.pathscale.com ([64.160.42.68]:17868 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932455AbWAKWl1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:41:27 -0500
Content-Type: multipart/mixed; boundary="===============1783597344=="
MIME-Version: 1.0
Subject: [PATCH 0 of 3] MMIO 32-bit copy routine, the final frontier
Message-Id: <patchbomb.1137019194@eng-12.pathscale.com>
Date: Wed, 11 Jan 2006 14:39:54 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, hch@infradead.org, ak@suse.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============1783597344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

After yet more review comments from several people, here is a reworked
set of 32-bit MMIO copy patches.  This may even be the final set.

These define the generic __raw_memcpy_toio32 as a weak symbol, which
arches are free to override.  We provide a specialised implementation
for x86_64.

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

--===============1783597344==--
