Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267491AbUGNRwT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267491AbUGNRwT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 13:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267492AbUGNRwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 13:52:19 -0400
Received: from maceio.ic.unicamp.br ([143.106.7.31]:34183 "EHLO
	maceio.ic.unicamp.br") by vger.kernel.org with ESMTP
	id S267491AbUGNRwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 13:52:09 -0400
From: Rafael =?iso-8859-1?q?=C1vila_de_Esp=EDndola?= 
	<rafael.espindola@ic.unicamp.br>
To: linux-kernel@vger.kernel.org
Subject: ppc64 compile error
Date: Wed, 14 Jul 2004 14:55:34 -0300
User-Agent: KMail/1.6.2
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407141455.34674.rafael.espindola@ic.unicamp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was trying to compile a kernel for ppc64 and had the following problems:

1)

rivers/video/imsttfb.c uses the function "nvram_read_byte"  but it is not 
defined in this architecture.
2)

the ppc64 architecture doesn't have agp.h. This prevents 
drivers/char/agp/backend.c from compiling.

3)
sound/ppc/pmac.c includes asm/feture.h but it could not be found:
sound/ppc/pmac.c:36:25: asm/feature.h: No such file or directory

Removing the corresponding options from .config results in a successful 
compilation.

Rafael
