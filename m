Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUHSLRS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUHSLRS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 07:17:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265301AbUHSLRS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 07:17:18 -0400
Received: from ozlabs.org ([203.10.76.45]:29593 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265331AbUHSLQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 07:16:19 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16676.35837.215958.814591@cargo.ozlabs.ibm.com>
Date: Thu, 19 Aug 2004 21:16:13 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org, viro@parcelfarce.linux.theplanet.co.uk
Cc: Olof Johansson <olof@austin.ibm.com>, linux-kernel@vger.kernel.org
Subject: Alignment of bitmaps for ext2_set_bit et al.
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What can we assume about the alignment of the bitmap pointer passed to
the ext2_{set,clear}_bit_atomic functions?  Can we assume that they
will be aligned to an long boundary (8 bytes on 64-bit)?

Olof has made a patch that uses atomics for these on ppc64 rather than
locking and unlocking a lock, but it will only work correctly if the
bitmap is always 8-byte aligned.

Paul.
