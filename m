Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314607AbSDFOxv>; Sat, 6 Apr 2002 09:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314610AbSDFOxu>; Sat, 6 Apr 2002 09:53:50 -0500
Received: from gold.muskoka.com ([216.123.107.5]:57356 "EHLO gold.muskoka.com")
	by vger.kernel.org with ESMTP id <S314607AbSDFOxu>;
	Sat, 6 Apr 2002 09:53:50 -0500
Message-ID: <3CAF0AAA.2523495A@yahoo.com>
Date: Sat, 06 Apr 2002 09:48:10 -0500
From: Paul Gortmaker <p_gortmaker@yahoo.com>
MIME-Version: 1.0
To: martin@dalecki.de
CC: linux-kernel@vger.kernel.org
Subject: ide_setup causes boot time hang
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Using any ide related bootprompt causes the dreaded

	Uncompressing Linux... Ok, booting the kernel.  *[HANG]*

with a *non-PCI* based kernel.  I traced it down to the early call to
ide_init_default_hwifs that a bootprompt causes to happen, but I sort
of lost interest once I tracked it down to the IDE code :)  Happens 
with 2.5.8pre2, 2.5.7 and possibly earlier kernels as well.

Paul.

