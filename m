Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266278AbTAPP5m>; Thu, 16 Jan 2003 10:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266453AbTAPP5l>; Thu, 16 Jan 2003 10:57:41 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:38793 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S266278AbTAPP5l>; Thu, 16 Jan 2003 10:57:41 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15910.55436.680525.450310@laputa.namesys.com>
Date: Thu, 16 Jan 2003 19:06:36 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Chris Mason <mason@suse.com>
Cc: Oleg Drokin <green@namesys.com>, linux-kernel@vger.kernel.org,
       eazgwmir@umail.furryterror.org, viro@math.psu.edu
Subject: Re: [2.4] VFS locking problem during concurrent link/unlink
In-Reply-To: <1042732927.31100.2205.camel@tiny.suse.com>
References: <20030116140015.A17612@namesys.com>
	<1042731580.31099.2195.camel@tiny.suse.com>
	<20030116184352.A32192@namesys.com>
	<1042732927.31100.2205.camel@tiny.suse.com>
X-Mailer: VM 7.07 under 21.5  (beta9) "brussels sprouts" XEmacs Lucid
X-Windows: power tools for power losers.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason writes:
 > On Thu, 2003-01-16 at 10:43, Oleg Drokin wrote:

[...]

 > 
 > link count at 1
 > reiserfs_link: make new directory entry for link, schedule()
 > reiserfs_unlink: dec link count to zero, remove file stat data
 > reiserfs_link: inc link count, return thinking the stat data is still
 > there

What protects ext2 from doing the same on the SMP?

 > 
 > All of which leads to expanding chaos as we process this link pointing
 > to nowhere but still have a valid in ram inode pointing to it.
 > 
 > -chris

Nikita.

 > 
 > 
