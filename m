Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265763AbUBFTLl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 14:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265756AbUBFTLH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 14:11:07 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:55980 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S265763AbUBFTK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 14:10:58 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: VFS locking: f_pos thread-safe ?
Date: Fri, 06 Feb 2004 19:59:45 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.02.06.18.59.44.936432@smurf.noris.de>
References: <402359E1.6000007@ntlworld.com> <20040206011630.42ed5de1.akpm@osdl.org> <40235DCC.2060606@ntlworld.com> <20040206013523.394d89f1.akpm@osdl.org> <pan.2004.02.06.10.19.57.885433@smurf.noris.de> <20040206111853.GE21151@parcelfarce.linux.theplanet.co.uk>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1076093985 32380 192.109.102.35 (6 Feb 2004 18:59:45 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Fri, 6 Feb 2004 18:59:45 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, viro wrote:

> "Somebody made a guess about undefined behaviour"

Guess what? The manpage says that read(2) return N bytes and advances the
file pointer by N bytes. It doesn't talk, much less caution, about threads.

YOU may immediately know, based on your kernel knowledge or whatever, that
things get somewhat undefined when two threads do that at the same time,
but it's NOT AT ALL obvious to a "normal" application programmer. There's
plenty of system calls that CAN be done concurrently, after all.

So we tried the simple idea, it didn't work, we grumbled a bit ;-) and
then did something else instead. Not a big deal.

Please save your "translations" for stupid ideas that are obviously so
without in-depth kernel knowledge or equivalent.

Thank you.

-- 
Matthias Urlichs
