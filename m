Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTLDOU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 09:20:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTLDOU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 09:20:59 -0500
Received: from mail.fh-wedel.de ([213.39.232.194]:6789 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S262098AbTLDOU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 09:20:57 -0500
Date: Thu, 4 Dec 2003 15:17:25 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: partially encrypted filesystem
Message-ID: <20031204141725.GC7890@wohnheim.fh-wedel.de>
References: <1070485676.4855.16.camel@nucleon> <20031203214443.GA23693@wohnheim.fh-wedel.de> <Pine.LNX.4.58.0312031600460.2055@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.58.0312031600460.2055@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 December 2003 16:08:17 -0800, Linus Torvalds wrote:
> On Wed, 3 Dec 2003, Jörn Engel wrote:
> >
> > Haven't heard about anything working yet, but it shouldn't be too hard
> > to change something existing.  For jffs2, I would guesstimate one or
> > two month to add the necessary bits, but jffs2 is not first choice as
> > a hard drive filesystem.  Not sure about other filesystems.
> 
> Encryption is not that easy to just tack on to most existing filesystems
> for one simple reason: for performance (and memory footprint) reasons,
> most of the filesystems out there are doing "IO in place". In other words,
> they do IO directly into and directly from the page cache.
> 
> With an encrypted filesystem, you can't do that. Or rather: you can do it
> if the filesystem is read-only, but you definitely CANNOT do it on
> writing. For writing you have to marshall the output buffer somewhere
> else (and quite frankly, it tends to become a lot easier if you can do
> that for reading too).

Isn't that a problem already handled by all compressing filesystems?
Or did I miss something really stupid?

Jörn

-- 
Optimizations always bust things, because all optimizations are, in
the long haul, a form of cheating, and cheaters eventually get caught.
-- Larry Wall 
