Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265149AbTLCUFI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 15:05:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265150AbTLCUFI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 15:05:08 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:3216 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id S265149AbTLCUFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 15:05:01 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Jens Axboe <axboe@suse.de>
Date: Thu, 4 Dec 2003 07:04:43 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16334.16859.886609.956641@notabene.cse.unsw.edu.au>
Cc: Linus Torvalds <torvalds@osdl.org>,
       David =?iso-8859-1?Q?Mart=EDnez?= Moreno <ender@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       clubinfo.servers@adi.uam.es, Ingo Molnar <mingo@elte.hu>
Subject: Re: Errors and later panics in 2.6.0-test11.
In-Reply-To: message from Jens Axboe on Wednesday December 3
References: <200312031417.18462.ender@debian.org>
	<Pine.LNX.4.58.0312030757120.5258@home.osdl.org>
	<20031203162045.GA27964@suse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday December 3, axboe@suse.de wrote:
> > 
> > Interesting. Another RAID 0 problem report..
> 
> Hmm did _all_ reports include raid-0, or just "some" raid? I'm looking
> at the bio_pair stuff which raid-0 is the only user of, something looks
> fishy there.

I think this is the first raid0 related problem I have seen for a
while.  Others were raid1 and raid5.

Once an array is set up and running there is minimal common code
between the different levels so it is very unlikely to be the same
problem in all three cases.

xfs seems to figure almost as prominantly as raid (the raid1 bug was
ext3), but maybe it's just that xfs over raid is a popular
configuration. 

NeilBrown
