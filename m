Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263453AbUART6r (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 14:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263466AbUART6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 14:58:47 -0500
Received: from play.smurf.noris.de ([192.109.102.42]:41384 "EHLO
	play.smurf.noris.de") by vger.kernel.org with ESMTP id S263453AbUART6q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 14:58:46 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Matthias Urlichs <smurf@smurf.noris.de>
Newsgroups: smurf.list.linux.kernel
Subject: Re: [PATCH] Re: [2.6.0, pktgen] divide-by-zero
Date: Sun, 18 Jan 2004 20:58:16 +0100
Organization: {M:U} IT Consulting
Message-ID: <pan.2004.01.18.19.58.14.872180@smurf.noris.de>
References: <20031231111316.GA10218@gnu.org> <20040118154802.GE10397@wohnheim.fh-wedel.de>
NNTP-Posting-Host: linux.smurf.noris.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Trace: play.smurf.noris.de 1074455896 7871 192.109.102.39 (18 Jan 2004 19:58:16 GMT)
X-Complaints-To: smurf@noris.de
NNTP-Posting-Date: Sun, 18 Jan 2004 19:58:16 +0000 (UTC)
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jörn Engel wrote:

> +		safe_total += 1 - (!!safe_total); /* avoid divide-by-zero */

That's a (binary ;-) order of magnitude more complicated than necessary:

>> +		safe_total += !safe_total; /* avoid divide-by-zero */

-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
To believe that the nonexistence of God is a fact on the level of water
not running uphill, or the moon not having an atmosphere, requires far
more faith than I could ever muster. -- Arthur D. Hlavaty

