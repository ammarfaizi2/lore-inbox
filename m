Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964863AbWIDM5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964863AbWIDM5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 08:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964869AbWIDM5v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 08:57:51 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:53445 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S964863AbWIDM5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 08:57:50 -0400
Date: Mon, 4 Sep 2006 14:57:44 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Josef Sipek <jsipek@cs.sunysb.edu>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, hch@infradead.org, akpm@osdl.org,
       viro@ftp.linux.org.uk
Subject: Re: [PATCH 00/22][RFC] Unionfs: Stackable Namespace Unification Filesystem
Message-ID: <20060904125744.GA1961@wohnheim.fh-wedel.de>
References: <20060901013512.GA5788@fsl.cs.sunysb.edu> <20060903110507.GD4884@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060903110507.GD4884@ucw.cz>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 September 2006 11:05:08 +0000, Pavel Machek wrote:
> 
> > - Modifying a Unionfs branch directly, while the union is mounted, is
> >   currently unsupported.  Any such change may cause Unionfs to oops and it
> >   can even result in data loss!
> 
> I'm not sure if that is acceptable. Even root user should be unable to
> oops the kernel using 'normal' actions.

Direct modification of branches is similar to direct modification of
block devices underneith a mounted filesystem.  While I agree that
such a thing _should_ not oops the kernel, I'd bet that you can easily
run a stresstest on a filesystem while randomly flipping bits in the
block device and get just that.

There are bigger problems in unionfs to worry about.

Jörn

-- 
Simplicity is prerequisite for reliability.
-- Edsger W. Dijkstra
