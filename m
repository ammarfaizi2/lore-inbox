Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265335AbUBAPZj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 10:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265326AbUBAPZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 10:25:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24785 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265333AbUBAPZb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 10:25:31 -0500
Date: Sun, 1 Feb 2004 16:25:24 +0100
From: Jens Axboe <axboe@suse.de>
To: Daniel Pittman <daniel@rimspace.net>
Cc: linux-kernel@vger.kernel.org, Mans Matulewicz <cybermans@xs4all.nl>
Subject: Re: ide-cdrom / atapi burning bug - 2.6.1
Message-ID: <20040201152524.GG11683@suse.de>
References: <1075511134.5412.59.camel@localhost> <20040131093438.GS11683@suse.de> <401BF122.2090709@blue-labs.org> <20040131184923.GD11683@suse.de> <87r7xfy8gb.fsf@enki.rimspace.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r7xfy8gb.fsf@enki.rimspace.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 01 2004, Daniel Pittman wrote:
> On Sat, 31 Jan 2004, Jens Axboe wrote:
> > On Sat, Jan 31 2004, David Ford wrote:
> >> I don't have an RW, but when my cdrom fixates, it stalls everything 
> >> while it's fixating.  I have an nForce chipset.  (2.6.x)
> > 
> > Does "everything" mean everything on that ide channel? If so, then
> > that's a hardware limitation.
> 
> My IBM A31p (Intel 845 chipset) had a similar problem with the CD
> burner. Using the '-immed' flag resolved the issue for me.

(Dave cut from cc, annoying auth process required to mail him)

immed will help, because it causes the command to 'release' in as close
a sense to the word as ide allows. I'm not sure if error handling works
correctly in that case?

-- 
Jens Axboe

