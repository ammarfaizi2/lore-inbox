Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261858AbTEMP6K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261866AbTEMP6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:58:09 -0400
Received: from deviant.impure.org.uk ([195.82.120.238]:22417 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S261858AbTEMP44 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:56:56 -0400
Date: Tue, 13 May 2003 17:09:48 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6 must-fix list, v2
Message-ID: <20030513160948.GA6594@suse.de>
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
 > >>>>> " " == Dave Jones <davej@codemonkey.org.uk> writes:
 > 
 >      > I had thought that the 2.4 server survived this. I just did a
 >      > test with a 2.4.21pre7 kernel and found the same behaviour, so
 >      > this isn't a regression, just something thats not very nice.
 > 
 > Then I'm confused as to what you are saying. Are we talking about a
 > full NFS server crash or just a temporary 'server not responding'
 > situation?

ok, I've now established that kernel version is irrelevant.
the server keeps on ticking, no problems.
the client (which runs fsx on an nfs mount) fails.

Two failure modes.
1, fsx dies with bus error. This is infrequent (seen it once)
   The most common failure mode is..
2, fsx fails. Different failure each time. Usually takes a minute
   to trigger.

(16:30:08:root@tetrachloride:mesh)# ~/fsx voon
truncating to largest ever: 0x13e76
truncating to largest ever: 0x2e52c
truncating to largest ever: 0x3c2c2
truncating to largest ever: 0x3f15f
truncating to largest ever: 0x3fcb9
truncating to largest ever: 0x3fe96
truncating to largest ever: 0x3ff9d
Size error: expected 0x2126e stat 0x21546 seek 0x21546
LOG DUMP (7665 total operations):
7666(242 mod 256): READ	0x1b20b thru 0x215b7	(0x63ad bytes)
7667(243 mod 256): MAPWRITE 0x247ef thru 0x26e9f	(0x26b1 bytes)
7668(244 mod 256): WRITE	0x26fc thru 0x11d2f	(0xf634 bytes)
7669(245 mod 256): TRUNCATE DOWN	from 0x3b18c to 0x1cbfc
7670(246 mod 256): MAPREAD	0x7f92 thru 0xd860	(0x58cf byte
....
etc...

 > Does NFS over TCP fix it, for instance?

Untested, I can give that a try.

		Dave

