Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbUDQQsC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Apr 2004 12:48:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263993AbUDQQsC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Apr 2004 12:48:02 -0400
Received: from disk.smurf.noris.de ([192.109.102.53]:49604 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S263990AbUDQQsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Apr 2004 12:48:00 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: NFS and kernel 2.6.x
Date: Sat, 17 Apr 2004 18:44:01 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.04.17.16.44.00.630010@smurf.noris.de>
References: <20040416011401.GD18329@widomaker.com> <1082079061.7141.85.camel@lade.trondhjem.org> <20040415185355.1674115b.akpm@osdl.org> <1082084048.7141.142.camel@lade.trondhjem.org> <20040416045924.GA4870@linuxace.com> <1082093346.7141.159.camel@lade.trondhjem.org>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1082220239 25055 192.109.102.35 (17 Apr 2004 16:43:59 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sat, 17 Apr 2004 16:43:59 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Trond Myklebust wrote:

> As for blanket statements like the above: I have seen no evidence yet
> that they are any more warranted in 2.6.x than they were in 2.4.x.

Oh, I saw the problem too: a slow client couldn't do full-size reads from
a fast server because the buffer on the client's network card was just 8k.

Granted that the client is a slow m68k Mac, but 2.4 was fast enough to get
the first packet entirely off the card before the last one overruns the
buffer -- while 2.6 has a bit more latency, so it can't.

Apparently that bit of increased latency is offset by the fact that the
machine still limps along if I packet-bomb it. Under 2.4 it locked solid,
so overall I think that the 2.6 situation is an improvement.

-- 
Matthias Urlichs
