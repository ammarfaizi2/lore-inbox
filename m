Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265362AbSKEXtb>; Tue, 5 Nov 2002 18:49:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265375AbSKEXtb>; Tue, 5 Nov 2002 18:49:31 -0500
Received: from dp.samba.org ([66.70.73.150]:53403 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265373AbSKEXt3>;
	Tue, 5 Nov 2002 18:49:29 -0500
From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15816.23157.790358.720568@argo.ozlabs.ibm.com>
Date: Wed, 6 Nov 2002 10:55:33 +1100
To: linux-kernel@vger.kernel.org
Cc: davidm@snapgear.com
Subject: [RANT] Totally inadequate commenting in flat.h
X-Mailer: VM 7.07 under Emacs 20.7.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looking over the recent changes in Linus' tree, I saw there was this
new file, include/linux/flat.h.  Hmmm, uninformative name, what's this
file about?  I look in the file and here is how it starts:

/* Copyright (C) 1998  Kenneth Albanowski <kjahds@kjahds.com>
 *                     The Silver Hammer Group, Ltd.
 * Copyright (C) 2002  David McCullough <davidm@snapgear.com>
 */

#ifndef _LINUX_FLAT_H
#define _LINUX_FLAT_H

#define	FLAT_VERSION			0x00000004L

/*
 * To make everything easier to port and manage cross platform
 * development,  all fields are in network byte order.
 */

struct flat_hdr {
	char magic[4];
	unsigned long rev;          /* version (as above) */

etc.

*Completely* uninformative.  How is anyone supposed to know what this
relates to?  Is it something to do with a network device, or a
filesystem, or an executable format, or what?

[And no, don't reply to this telling me what it's about, add some
comments to the file instead.]

Paul.
