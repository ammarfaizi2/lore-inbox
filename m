Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262465AbVFXN2W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262465AbVFXN2W (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 09:28:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262632AbVFXN2W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 09:28:22 -0400
Received: from main.gmane.org ([80.91.229.2]:385 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262465AbVFXN2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 09:28:15 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: Mercurial vs Updated git HOWTO for kernel hackers
Date: Fri, 24 Jun 2005 15:16:13 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.06.24.13.16.10.406827@smurf.noris.de>
References: <42B9E536.60704@pobox.com> <20050623235634.GC14426@waste.org> <20050624064101.GB14292@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Cc: git@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Petr Baudis wrote:

> Switching branches in place will be supported soon (although I have
> doubts about its usefulness).

Well, I don't. Main reason: It's simply a lot faster to create+switch to a
branch locally for doing independent work, than to hardlink the whole
Linux directory tree into a clone tree.

Having one tree also simpifies the "what do I have that's not merged yet"
question -- just call "gitk $(cat .git/refs/heads/*)". ;-)

The only problem I have with it is that "git-read-tree -m -u"
doesn't delete files yet. To repeat my question from last week:
>> Would it be safe to add all files for which
>> read_tree.c:merge_cache:fn() returns zero to a "delete me" list?
(files on which which then actually get deleted, of course, if g-r-t
doesn't find any problems.)

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Politics -- the gentle art of getting votes from the poor and campaign
funds from the rich by promising to protect each from the other.
		-- Oscar Ameringer


