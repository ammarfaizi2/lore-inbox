Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261633AbVAMOk0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261633AbVAMOk0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 09:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbVAMOk0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 09:40:26 -0500
Received: from aun.it.uu.se ([130.238.12.36]:31220 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261633AbVAMOkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 09:40:23 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16870.34895.217241.479250@alkaid.it.uu.se>
Date: Thu, 13 Jan 2005 15:40:15 +0100
To: afleming@freescale.com
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.11-rc1 compile failure on ppc32
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When the kernel is configured for a PMAC (via MULTIPLATFORM),
then arch/ppc/kernel/perfmon.c fails to compile because the
MMCR0_PMXE macro is undefined.

Adding a "#define MMCR0_PMXE 0x04000000" somewhere visible
fixes this.

/Mikael
