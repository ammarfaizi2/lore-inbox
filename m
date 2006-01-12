Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964851AbWALAai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWALAai (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 19:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964858AbWALAai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 19:30:38 -0500
Received: from mx.pathscale.com ([64.160.42.68]:53462 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S964851AbWALAai (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 19:30:38 -0500
Content-Type: multipart/mixed; boundary="===============1603230373=="
MIME-Version: 1.0
Subject: [PATCH 0 of 2] Much smaller MMIO copy patches
Message-Id: <patchbomb.1137025774@eng-12.pathscale.com>
Date: Wed, 11 Jan 2006 16:29:34 -0800
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org
Cc: rdreier@cisco.com, ak@suse.de, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============1603230373==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

These MMIO copy patches are lean, mean, and apparently clean.

These define the generic __raw_memcpy_toio32 as a weak symbol, which
arches are free to override.  We provide a specialised implementation
for x86_64.

We also introduce include/linux/io.h, which is tiny now, but a candidate
for later cleanups of all the per-arch asm-*/io.h files.

These patches should apply cleanly against current -git, and have been
tested on i386 and x86_64.  The symbol shows up in the built vmlinux,
as one might hope.

The patch series is as follows:

raw_memcpy_io.patch
  Introduce the generic MMIO 32-bit copy routine.

x86_64-raw_memcpy_io.patch
  Add a faster __raw_memcpy_io32 routine to x86_64.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

--===============1603230373==--
