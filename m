Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbTEMRZM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 13:25:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbTEMRZM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 13:25:12 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:11414 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S262273AbTEMRZJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 13:25:09 -0400
Date: Tue, 13 May 2003 18:38:01 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513173801.GA2763@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
References: <20030512155417.67a9fdec.akpm@digeo.com> <20030512155511.21fb1652.akpm@digeo.com> <shswugvjcy9.fsf@charged.uio.no> <20030513135756.GA676@suse.de> <16065.3159.768256.81302@charged.uio.no> <20030513152228.GA4388@suse.de> <16065.4109.129542.777460@charged.uio.no> <20030513154741.GA4511@suse.de> <16065.5911.55131.430734@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16065.5911.55131.430734@charged.uio.no>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 13, 2003 at 06:02:31PM +0200, Trond Myklebust wrote:
 > Then I'm confused as to what you are saying. Are we talking about a
 > full NFS server crash or just a temporary 'server not responding'
 > situation? Does NFS over TCP fix it, for instance?

Just to keep you busy..
I had thought NFS over TCP fixed it. It rang for a lot longer
(around 50 minutes), and then did the following..
Looks like a different bug to my untrained eye.

(17:51:02:root@tetrachloride:mesh)# ~/fsx voon
truncating to largest ever: 0x13e76
truncating to largest ever: 0x2e52c
truncating to largest ever: 0x3c2c2
truncating to largest ever: 0x3f15f
truncating to largest ever: 0x3fcb9
truncating to largest ever: 0x3fe96
truncating to largest ever: 0x3ff9d
truncating to largest ever: 0x3ffff
skipping zero size read
skipping zero size write
Size error: expected 0x30501 stat 0x1f486 seek 0x1f486
LOG DUMP (90892 total operations):
90893(13 mod 256): MAPREAD	0x227bf thru 0x2e4a4	(0xbce6 bytes)
90894(14 mod 256): WRITE	0x20dbf thru 0x28e7b	(0x80bd bytes)
90895(15 mod 256): READ	0x1d762 thru 0x241ff	(0x6a9e bytes)
90896(16 mod 256): WRITE	0x26621 thru 0x33855	(0xd235 bytes)
90897(17 mod 256): READ	0x28df3 thru 0x33603	(0xa811 bytes)
90898(18 mod 256): READ	0xe303 thru 0x13c31	(0x592f bytes)
90899(19 mod 256): WRITE	0x3b680 thru 0x3ffff	(0x4980 bytes) HOLE
90900(20 mod 256): MAPWRITE 0x33ba5 thru 0x34740	(0xb9c bytes)
90901(21 mod 256): READ	0x15ed6 thru 0x2546a	(0xf595 bytes)
90902(22 mod 256): MAPWRITE 0x188e8 thru 0x260ec	(0xd805 bytes)
90903(23 mod 256): WRITE	0x29f99 thru 0x2b02a	(0x1092 bytes)
90904(24 mod 256): TRUNCATE DOWN	from 0x40000 to 0x279fb

Complete (60KB) fsx log is at http://www.codemonkey.org.uk/cruft/voon.fsxlog

		Dave

