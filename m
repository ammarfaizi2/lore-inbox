Return-Path: <linux-kernel-owner+w=401wt.eu-S1754884AbWL1Pxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754884AbWL1Pxo (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 10:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754885AbWL1Pxo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 10:53:44 -0500
Received: from sorrow.cyrius.com ([65.19.161.204]:37943 "EHLO
	sorrow.cyrius.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754884AbWL1Pxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 10:53:43 -0500
Date: Thu, 28 Dec 2006 16:53:27 +0100
From: Martin Michlmayr <tbm@cyrius.com>
To: Gordon Farquharson <gordonfarquharson@gmail.com>
Cc: Linus Torvalds <torvalds@osdl.org>, David Miller <davem@davemloft.net>,
       ranma@tdiedrich.de, Peter Zijlstra <a.p.zijlstra@chello.nl>,
       andrei.popa@i-neo.ro, Andrew Morton <akpm@osdl.org>, hugh@veritas.com,
       nickpiggin@yahoo.com.au, arjan@infradead.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one
Message-ID: <20061228155327.GA22876@deprecation.cyrius.com>
References: <20061226.205518.63739038.davem@davemloft.net> <Pine.LNX.4.64.0612271601430.4473@woody.osdl.org> <Pine.LNX.4.64.0612271636540.4473@woody.osdl.org> <20061227.165246.112622837.davem@davemloft.net> <Pine.LNX.4.64.0612271835410.4473@woody.osdl.org> <97a0a9ac0612272032uf5358c4qf12bf183f97309a6@mail.gmail.com> <Pine.LNX.4.64.0612272039411.4473@woody.osdl.org> <97a0a9ac0612272120g144d2364n932d6f66728f162e@mail.gmail.com> <20061228101311.GA9672@flint.arm.linux.org.uk> <97a0a9ac0612280615y37a5661cg56c854fc9c780ebb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97a0a9ac0612280615y37a5661cg56c854fc9c780ebb@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Gordon Farquharson <gordonfarquharson@gmail.com> [2006-12-28 07:15]:
> Thanks for the fix, Russell.
> 
> I can now trigger the (real) problem by using a 25 MB file (100 << 18)
> and the Linksys NSLU2 (ARM, IXP420 processor, 32 MB RAM).

Me too (using 100 << 18).  Interestingly, I don't seem to get any
corruption on a different ARM board, an IOP32x based machine with 128
MB RAM.
-- 
Martin Michlmayr
http://www.cyrius.com/
