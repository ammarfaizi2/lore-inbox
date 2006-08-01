Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932513AbWHAKqM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932513AbWHAKqM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 06:46:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWHAKqM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 06:46:12 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:14824 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932513AbWHAKqL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 06:46:11 -0400
Date: Tue, 1 Aug 2006 12:40:14 +0200
To: Adrian Ulrich <reiser4@blinkenlights.ch>
Cc: Matthias Andree <matthias.andree@gmx.de>, vonbrand@inf.utfsm.cl,
       ipso@snappymail.ca, reiser@namesys.com, lkml@lpbproductions.com,
       jeff@garzik.org, tytso@mit.edu, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion
Message-ID: <20060801104013.GA18239@aitel.hist.no>
References: <1153760245.5735.47.camel@ipso.snappymail.ca> <200607241806.k6OI6uWY006324@laptop13.inf.utfsm.cl> <20060731125846.aafa9c7c.reiser4@blinkenlights.ch> <20060731144736.GA1389@merlin.emma.line.org> <20060731175958.1626513b.reiser4@blinkenlights.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060731175958.1626513b.reiser4@blinkenlights.ch>
User-Agent: Mutt/1.5.11+cvs20060403
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 05:59:58PM +0200, Adrian Ulrich wrote:
> Hello Matthias,
> 
> > This looks rather like an education issue rather than a technical limit.
> 
> We aren't talking about the same issue: I was asking to do it
> on-the-fly. Umounting the filesystem, running e2fsck and resize2fs
> is something different ;-)
> 
> > Which is untrue at least for Solaris, which allows resizing a life file
> > system. FreeBSD and Linux require an unmount.
> 
> Correct: You can add more inodes to a Solaris UFS on-the-fly if you are
> lucky enough to have some free space available.
> 
> A colleague of mine happened to create a ~300gb filesystem and started
> to migrate Mailboxes (Maildir-style format = many small files (1-3kb))
> to the new LUN. At about 70% the filesystem ran out of inodes; Not a
> big deal with VxFS because such a problem is fixable within seconds.
> What would have happened if he had used UFS? mkfs -G wouldn't work
> because he had no additional Diskspace left... *ouch*..
> 
This case is solvable by planning.  When you know that the new fs
must be created with all inodes from the start, simply count
how many you need before migration.  (And add a decent safety margin.)
That's what I do with my home machine ask disks wear out every third 
year or so. The tools for ext2/3 tells how many inodes are in use,
and the new fs can be made accordingly.  The approach works for bigger
machines too of course.

Helge Hafting

