Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267945AbUGaNxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267945AbUGaNxT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jul 2004 09:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267951AbUGaNxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jul 2004 09:53:19 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:63685 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S267945AbUGaNxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jul 2004 09:53:18 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
Date: Sat, 31 Jul 2004 15:52:53 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.07.31.13.52.52.829100@smurf.noris.de>
References: <16734.1090513167@ocs3.ocs.com.au> <20040725235705.57b804cc.akpm@osdl.org> <m1r7qw7v9e.fsf@ebiederm.dsl.xmission.com> <200407280903.37860.jbarnes@engr.sgi.com> <25870000.1091042619@flay> <m14qnr7u7b.fsf@ebiederm.dsl.xmission.com> <20040728133337.06eb0fca.akpm@osdl.org> <1091044742.31698.3.camel@localhost.localdomain> <m1llh367s4.fsf@ebiederm.dsl.xmission.com> <1091055311.31923.3.camel@localhost.localdomain> <20040728172204.2ecc5cdd.akpm@osdl.org> <1091109427.865.1.camel@localhost.localdomain> <20040729111728.5d2bb5c8.akpm@osdl.org>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1091281973 13194 192.109.102.35 (31 Jul 2004 13:52:53 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sat, 31 Jul 2004 13:52:53 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Andrew Morton wrote:

> See above.  We assume that network RX DMA won't be scribbling in the 16MB
> which was pre-reserved.  That's reasonable.  We _have_ to assume that.

If you wait a few seconds before verifying that the checksum of the
rescue kernel is still correct, then you should be able to be reasonably
sure that there won't be any corruption.

Nothing's 100% here, of course. But the chances that a delayed network DMA
causes the rescue kernel to write its dump data to an area it shouldn't
write to are small enough not to matter. IMHO.

-- 
Matthias Urlichs
