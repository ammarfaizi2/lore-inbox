Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261422AbUKBV3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261422AbUKBV3L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 16:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261412AbUKBV3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 16:29:11 -0500
Received: from run.smurf.noris.de ([192.109.102.41]:20940 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261422AbUKBV3E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 16:29:04 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: [PATCH][plugsched 0/28] Pluggable cpu scheduler framework
Date: Tue, 02 Nov 2004 22:28:33 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.11.02.21.28.32.869425@smurf.noris.de>
References: <4183A602.7090403@kolivas.org> <20041031233313.GB6909@elf.ucw.cz> <20041101114124.GA31458@elte.hu>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1099430913 1339 192.109.102.35 (2 Nov 2004 21:28:33 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Tue, 2 Nov 2004 21:28:33 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Ingo Molnar wrote:

> I believe that by compartmenting in the wrong way [*] we kill the
> natural integration effects. We'd end up with 5 (or 20) bad generic
> schedulers that happen to work in one precise workload only, but there
> would not be enough push to build one good generic scheduler, because
> the people who are now forced to care about the Linux scheduler would be
> content about their specialized schedulers.

I don't think so. There are multiple attempts to build a better
generic scheduler (Con's for one), so there's your counterexample right
here. However, testing a different scheduler currently requires a kernel
recompile and a reboot.

I hate that. Ideally, the scheduler would be hotpluggable... but I can
live with a reboot. I don't think a kernel recompile to switch schedulers
makes sense, though, so I for one am likely not to bother. So far.

You can't actually develop a better scheduler if people need to go too
far out of their way to compare them.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

