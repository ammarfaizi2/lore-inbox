Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266590AbUBLU5I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 15:57:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266593AbUBLU5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 15:57:07 -0500
Received: from pixpat.austin.ibm.com ([192.35.232.241]:9017 "EHLO
	shaggy.austin.ibm.com") by vger.kernel.org with ESMTP
	id S266590AbUBLU5B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:57:01 -0500
Date: Thu, 12 Feb 2004 14:56:55 -0600
From: shaggy@austin.ibm.com
Message-Id: <200402122056.i1CKut1t006255@kleikamp.dyn.webahead.ibm.com>
To: akpm@osdl.org
Subject: [PATCH] JFS: sane file name handling (0 of 2)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,
Please apply the following patches to -mm.  The first is just a cleanup, but
the second one changes the default translation of filenames into unicode.

There have been several complaints about the way that JFS tries to interpret
the character set of the file names rather than just treating them as strings
of bytes.  This patch makes the default behavior the "string of bytes"
treatment, while still allowing the charset-specific behavior with the
iocharset mount option.

I don't believe it will cause anyone too much trouble, but it should probably
spend a little time in -mm before hitting the mainline.

Thanks,
Shaggy
