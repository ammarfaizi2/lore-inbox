Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbUJZG5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUJZG5c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 02:57:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbUJZG5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 02:57:32 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:64158 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262114AbUJZG5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 02:57:30 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: BK kernel workflow
Date: Tue, 26 Oct 2004 08:57:26 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.10.26.06.57.26.374372@smurf.noris.de>
References: <20041023161253.GA17537@work.bitmover.com> <20041024144448.GA575@work.bitmover.com> <4d8e3fd304102409443c01c5da@mail.gmail.com> <20041024233214.GA9772@work.bitmover.com> <20041025114641.GU14325@dualathlon.random> <1098707342.7355.44.camel@localhost.localdomain> <20041025133951.GW14325@dualathlon.random> <20041025162022.GA27979@work.bitmover.com> <9e47339104102511182f916705@mail.gmail.com> <20041025230128.GA1232@work.bitmover.com> <9e473391041025192622ddfee3@mail.gmail.com>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1098773847 29373 192.109.102.35 (26 Oct 2004 06:57:27 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Tue, 26 Oct 2004 06:57:27 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jon Smirl wrote:

> For example  a digital signature trail on change sets that tracks who did
> what. Say I do some changes on my local tree, export it and
> mail it out on lkml. This change set is picked up by Andrew. Andrew
> munges on it some and sends it onto Linus. Linus changes another
> couple of lines and puts it in his tree.  Now I go to bkbits and look
> at the history for the lines changed. Can I see what Linus, Andrew and
> I have all changed including digital signatures?

Sure you can, if you use the "bksend" script Andrew can import your
changes into a bk tree, change them, and then send the combined changes to
Linus.

The problem is that unless both Andrew's and Linus' tree are at exactly
the same version yours is, there will be some merge changesets in between
which really muddle up the change history.

That's fixable, but "bk clone" plus "bk undo" are too expensive at the
moment -- if that took a few seconds instead of a few minutes, people
would probably do it more readily.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

