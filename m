Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262989AbUJ1Lvg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262989AbUJ1Lvg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 07:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262976AbUJ1Ltf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 07:49:35 -0400
Received: from moraine.clusterfs.com ([66.246.132.190]:52689 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S262989AbUJ1Lq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 07:46:57 -0400
Date: Thu, 28 Oct 2004 05:44:13 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: "Theodore Ts'o" <tytso@mit.edu>, Timo Sirainen <tss@iki.fi>,
       linux-kernel@vger.kernel.org
Subject: Re: readdir loses renamed files
Message-ID: <20041028114413.GL1343@schnapps.adilger.int>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Timo Sirainen <tss@iki.fi>, linux-kernel@vger.kernel.org
References: <431547F9-2624-11D9-8AC3-000393CC2E90@iki.fi> <20041025123722.GA5107@thunk.org> <20041028093426.GB15050@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028093426.GB15050@merlin.emma.line.org>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 28, 2004  11:34 +0200, Matthias Andree wrote:
> On Mon, 25 Oct 2004, Theodore Ts'o wrote:
> > And that's because there's no good way to do this without trashing the
> > performance of the system, especially when most applications don't
> > care.  (Do you really want your entire system running significantly
> > slower, penalizing all other applications on your system, just because
> > of one stupid/badly-written application?)
> 
> Please - is it really necessary that application writers are offended in
> this way? Timo is investing enormous time and effort in writing a *good*
> application, and he's effectively seeking a way to *robustly* deal with
> Maildir format mail storage. Please leave it at "readdir/getdents don't
> work the way you expect and cannot for this and that reason."
> 
> Timo tries to implement a *robust* Maildir reader and has just bumped
> into the flaws of DJB's "no-locking" store.
> 
> Yes, it's a mail server again that poses file system questions on this
> list; only it's IMAP this time rather than SMTP and directory
> synchronous I/O...

I read over in reiserfs-list that the reason for the crazy renaming is
to store "attributes" as part of the filename.  Why not just store them
as EAs as they were intended?  With the large inode patches (posted here
a couple of times already) the cost of storing EAs is negligible.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://members.shaw.ca/adilger/             http://members.shaw.ca/golinux/

