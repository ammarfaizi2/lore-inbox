Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262148AbUJZHcf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262148AbUJZHcf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 03:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbUJZHcf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 03:32:35 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:50599 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S262148AbUJZHca (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 03:32:30 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: BK kernel workflow
Date: Tue, 26 Oct 2004 09:32:20 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.10.26.07.32.20.563552@smurf.noris.de>
References: <41752E53.8060103@pobox.com> <Pine.LNX.4.58.0410241027320.13209@ppc970.osdl.org> <Pine.LNX.4.58.0410241045090.13209@ppc970.osdl.org> <200410242039.25407.mbuesch@freenet.de>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: server.smurf.noris.de 1098775941 4243 192.109.102.35 (26 Oct 2004 07:32:21 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Tue, 26 Oct 2004 07:32:21 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Michael Buesch wrote:

> What do kernel developers think about svk?
> (Yes, it's not mature, yet.)
> I mean the svk concept. Does it also suck for kernel development?

The basic idea seems to be "We need feature X. We have a system that's
mostly nice, but it cannot do X. Thus, graft a system to do X onto it.
Voila, one SCM which can do everything we need". Experience suggests
that if you do that, you end up with an ugly mess.

One reason why svk won't work for Linux is this:

A true peer-to-peer system requires that both branches are treated equal.
Bitkeeper got that one exactly right: if I have two repositories A and B,
then importing A to B is the same thing as importing B to A. SVN can't do
that, thus svk can't do it either.

There are others.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

