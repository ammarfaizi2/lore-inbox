Return-Path: <linux-kernel-owner+w=401wt.eu-S1751647AbXANTka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751647AbXANTka (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 14:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbXANTka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 14:40:30 -0500
Received: from moutng.kundenserver.de ([212.227.126.179]:55157 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646AbXANTk3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 14:40:29 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: O_DIRECT question
To: Bill Davidsen <davidsen@tmr.com>, Michael Tokarev <mjt@tls.msk.ru>,
       Chris Mason <chris.mason@oracle.com>, dean gaudet <dean@arctic.org>,
       Viktor <vvp01@inbox.ru>, Aubrey <aubreylee@gmail.com>,
       Hua Zhong <hzhong@gmail.com>, Hugh Dickins <hugh@veritas.com>,
       linux-kernel@vger.kernel.org, hch@infradead.org,
       kenneth.w.chen@intel.com, akpm@osdl.org
Reply-To: 7eggert@gmx.de
Date: Sun, 14 Jan 2007 20:39:50 +0100
References: <7BYkO-5OV-17@gated-at.bofh.it> <7BYul-6gz-5@gated-at.bofh.it> <7C74B-2A4-23@gated-at.bofh.it> <7CaYA-mT-19@gated-at.bofh.it> <7Cpuz-64X-1@gated-at.bofh.it> <7Cz0T-4PH-17@gated-at.bofh.it> <7CBcl-86B-9@gated-at.bofh.it> <7CBvH-52-9@gated-at.bofh.it> <7CBFn-hw-1@gated-at.bofh.it> <7CBP1-KI-3@gated-at.bofh.it> <7CBYG-WK-3@gated-at.bofh.it> <7CXmz-88G-29@gated-at.bofh.it> <7CXFR-8vZ-15@gated-at.bofh.it> <7DfMP-2ak-19@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1H6BCo-0000mv-TY@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@gmx.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen <davidsen@tmr.com> wrote:

> My point is, that there is code to handle sparse data now, without
> O_DIRECT involved, and if O_DIRECT bypasses that, it's not a problem
> with the idea of O_DIRECT, the kernel has a security problem.

The idea of O_DIRECT is to bypass the pagecache, and the pagecache is what
provides the security against reading someone else's data using sparse
files or partial-block-IO.
