Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266829AbUGVHr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266829AbUGVHr3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jul 2004 03:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266833AbUGVHr3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jul 2004 03:47:29 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:21140 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S266829AbUGVHrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jul 2004 03:47:18 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: [PATCH] Delete cryptoloop
Date: Thu, 22 Jul 2004 09:43:42 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.07.22.07.43.41.872460@smurf.noris.de>
References: <Pine.LNX.4.58.0407211609230.19655@devserv.devel.redhat.com> <20040721230044.20fdc5ec.akpm@osdl.org> <Pine.LNX.4.58.0407212319560.13098@devserv.devel.redhat.com>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1090482222 12450 192.109.102.35 (22 Jul 2004 07:43:42 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Thu, 22 Jul 2004 07:43:42 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, James Morris wrote:

> It would be good if we could get some further review on the issue by an 
> independent, well known cryptographer.

Well, I'm not, but ...

AFAIK, the main issue is: If I write some data to the start of block N, I
get a bit pattern. If I write the same data *anywhere* else (the middle of
block N, the start of block M != N, a different on-disk bit pattern must
result.

If there are identical bit patterns, then the system is vulnerable.
Obviously, this vulnerability doesn't depend on whether you're using
cryptoloop or dm-crypt.

-- 
Matthias Urlichs
