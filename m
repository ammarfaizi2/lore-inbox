Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264493AbUANTp0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUANTn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:43:58 -0500
Received: from stat1.steeleye.com ([65.114.3.130]:33410 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264493AbUANTmL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:42:11 -0500
Subject: Re: [PATCH] 2.6.1-mm2: Adjust MAX_MP_BUSSES for summit and generic
	subarches
From: James Bottomley <James.Bottomley@steeleye.com>
To: James Cleverdon <jamesclv@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 14 Jan 2004 14:42:06 -0500
Message-Id: <1074109327.1805.65.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summit has it's own mach_mpspec.h, so it won't even see the summit
changes you're proposing in mach-default:

+++ q1mm2/include/asm-i386/mach-generic/mach_mpspec.h	2004-01-13 
[...]
+#if defined(CONFIG_X86_SUMMIT) || defined(CONFIG_X86_GENERICARCH)

Putting summit specific pieces in the subarch default is the wrong way
to do it (and for this patch, it's even unnecessary since you modify the
summit mach_mpspec.h anyway).

James


