Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUGNTDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUGNTDY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 15:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267370AbUGNTDY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 15:03:24 -0400
Received: from zeus.kernel.org ([204.152.189.113]:61317 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S265139AbUGNTDV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 15:03:21 -0400
Subject: Re: XFS: how to NOT null files on fsck?
To: helgehaf@aitel.hist.no (Helge Hafting)
Date: Wed, 14 Jul 2004 20:53:15 +0200 (CEST)
From: "Anton Ertl" <anton@mips.complang.tuwien.ac.at>
Cc: linux-kernel@vger.kernel.org, cw@f00f.org (Chris Wedgwood),
       jk-lkml@sci.fi (Jan Knutar), lkml@tlinx.org (L A Walsh)
In-Reply-To: <20040713222411.GA1035@hh.idb.hist.no>
Reply-To: anton@mips.complang.tuwien.ac.at
X-Mailer: ELM [version 2.5 PL7]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E1BkosV-0003OY-0e@a4.complang.tuwien.ac.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> There is another solution - zero blocks when freeing them. (Or
> put them on a list for later zeroing when the fs isn't busy,
> in order to kee=EF=BF=BD=EF=BF=BDp good performance)
> 
> With this approach you don't need to zero a half-written
> block after a crash, which means you destroy less data.

I don't think half-written blocks are the problem (at least not a
frequent one).  More typical is written meta-data without written
data.  In that case your solution will give the same result as the
current solution, just at higher cost.

- anton

