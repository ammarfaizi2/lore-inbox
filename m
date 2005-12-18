Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965306AbVLRXhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965306AbVLRXhL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Dec 2005 18:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965307AbVLRXhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Dec 2005 18:37:11 -0500
Received: from cantor2.suse.de ([195.135.220.15]:43447 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965306AbVLRXhJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Dec 2005 18:37:09 -0500
From: Neil Brown <neilb@suse.de>
To: CaT <cat@zip.com.au>
Date: Mon, 19 Dec 2005 10:36:53 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17317.62101.886020.592277@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: anticipatory scheduler and raid rebuild
In-Reply-To: message from CaT on Tuesday December 13
References: <20051213052329.GM4212@zip.com.au>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday December 13, cat@zip.com.au wrote:
> I'll be able to play a bit more with this later but for now I thought
> I'd toss it into the wilderness. 

Thanks.

> 
> I had jsut setup a nice little server with WD 10k drives and s/w raid 1.
> The kernel is 2.6.14.3. The CPU is a p4 3Ghz and it's an Intel 82875P
> chipset. In order to test that it'll build ok with missing disks I
> pulled one out, booted, shutdown, put it back in and rebooted. I then
> went on to try and get one of the raids to rebuild with:
> 
> mdadm --manage -a /dev/md6 /dev/sdb8
> 
> And then the server slowed to a crawl. Well not even that. It slowed to
> the point of freezing and occasionally stuttering with activity other
> then the rebuild. I got a similar reaction when it was rebuilding
> it.

I've heard reports of this sort of thing before I think, but I'm
wondering why I never experience it.
What sort of drives do you have? What controller?
What filesystem are you running over the raid1?

> 
> So, does my hardware suck and AS is pushing it beyond its limits or is
> AS unsuitable for the task I am putting it through or is AS buggy and
> all should be well with it?

I suspect it is an odd interaction between md/raid1/rebuild and AS.
AS tries to guess how a process is behaving and the raid1/rebuild
process probably is confusing it.  But it is hard to say how until I
can reproduce it.

NeilBrown

