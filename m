Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265756AbUFIMnt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265756AbUFIMnt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 08:43:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265774AbUFIMnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 08:43:49 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:54162 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S265767AbUFIMnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 08:43:33 -0400
Date: Wed, 9 Jun 2004 14:43:02 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: chase.maupin@hp.com, iss_storagedev@hp.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [STACK] >4k call path in hp/compaq fibre channel driver
Message-ID: <20040609124302.GI21168@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase, I guess this code won't live long with 4k stacks.  Can you
please fix CpqTsProcessIMQEntry() and PeekIMQEntry()?

Linus, Andrew, how about marking CONFIG_SCSI_CPQFCTS as broken for the
time being?

stackframes for call path too long (4144):
    size  function
       0
____FAKE.Name.Chip.stat.Regi.LILP.Opti.high.lowe->ProcessIMQEntry
    2076  CpqTsProcessIMQEntry
    2052  PeekIMQEntry
      16  CpqTsGetSFQEntry
       0  __constant_memcpy
       0  __builtin_memcpy

Jörn

-- 
The grand essentials of happiness are: something to do, something to
love, and something to hope for.
-- Allan K. Chalmers
