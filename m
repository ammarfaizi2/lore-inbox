Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265493AbTLHQb0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 11:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265479AbTLHQ2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 11:28:39 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:12419 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S265478AbTLHQ1B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 11:27:01 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: incorrect inode count on reiserfs
Date: Mon, 08 Dec 2003 17:09:23 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2003.12.08.16.09.22.30237@smurf.noris.de>
References: <3FD47BFC.9020008@scssoft.com> <16340.33245.887082.96412@laputa.namesys.com> <slrnbt9322.27h.erik@bender.home.hensema.net>
NNTP-Posting-Host: p50847149.dip.t-dialin.net
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: play.smurf.noris.de 1070899761 2224 80.132.113.73 (8 Dec 2003 16:09:21 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Mon, 8 Dec 2003 16:09:21 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Erik Hensema wrote:

> But innwatch checks for a out-of-inodes condition. How can it differentiate
> between a undefined number of inodes (field set to 0) and a system that ran
> out of inodes (field dropped to 0)?
> 
Create a file. Watch that succeed. Check whether this succeeds, and that
the number of free inodes is still zero.
Delete the file. Check that the number of free inodes is _still_ zero.

Repeat a few times, with random sub-second delay if you're feeling
especially paranoid today, for added confidence.

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
"The Establishment Clause, unlike the Free Exercise Clause, does not
 depend upon any showing of direct governmental compulsion and is violated
 by the enactment of laws which establish an official religion whether
 those laws operate directly to coerce nonobserving individuals or not."
          [U.S. Supreme Court, Wallace v. Jaffree (1985)]

