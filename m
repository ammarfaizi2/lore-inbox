Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263823AbUBODk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 22:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbUBODk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 22:40:58 -0500
Received: from disk.smurf.noris.de ([192.109.102.53]:40843 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S263823AbUBODk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 22:40:57 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: JFS default behavior
Date: Sun, 15 Feb 2004 04:33:48 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.02.15.03.33.48.209951@smurf.noris.de>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <200402150006.23177.robin.rosenberg.lists@dewire.com> <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk> <200402150107.26277.robin.rosenberg.lists@dewire.com> <Pine.LNX.4.58.0402141827200.14025@home.osdl.org>
NNTP-Posting-Host: kiste.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: server.smurf.noris.de 1076816028 18980 192.109.102.35 (15 Feb 2004 03:33:48 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sun, 15 Feb 2004 03:33:48 +0000 (UTC)
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Linus Torvalds wrote:

> In short: the kernel talks bytestreams, and that implies that if you want
> to talk to the kernel, you HAVE TO USE UTF-8.
> 
> At which point there are no locale issues any more.

Not locale, but normalization problems and identical-glyph problems.

Which is actually worse, because you don't have filenames which look
like crap -- instead you have filenames which look perfectly sane, but
they still do not work. Example: is an á one character, or is it an a
followed by a composing ´?

Mac OSX, just as an example, only uses decomposed filenames. I don't know
the current situation, but 10.2 has major problems when you try to access
files with composite characters in their name (across NFS for instance).

I wonder if Linux, i.e. Linus ;-) should decree one single standard
normalization. (I am NOT saying that enforcing this would be the kernel's
job!)

-- 
Matthias Urlichs
