Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262224AbTJNHJv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 03:09:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTJNHJu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 03:09:50 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:7699 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S262224AbTJNHJg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 03:09:36 -0400
Date: Tue, 14 Oct 2003 00:09:33 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS patch for updating ctimes of renamed files
Message-ID: <20031014070932.GQ15809@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <JIEIIHMANOCFHDAAHBHOIELODAAA.alex_a@caltech.edu> <20031012071447.GJ8724@pegasys.ws> <3F8A3CE0.4060705@namesys.com> <20031013032431.1ed40c25.akpm@osdl.org> <3F8B93F7.2020805@namesys.com> <20031013232527.3cf5701f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031013232527.3cf5701f.akpm@osdl.org>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Vulnerable email reader detected!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 13, 2003 at 11:25:27PM -0700, Andrew Morton wrote:
> Hans Reiser <reiser@namesys.com> wrote:
> >
> > do you think schultz's arguments about why it is wrong are correct?  
> > They seem well thought out to me.
> 
> Well given that you've renamed the file, you do want the backup program to
> pick up the "new" file.  But it'd be a pretty lame backup program which was
> fooled by a missing ctime update.
> 
> Yes, John has a point but we're not going to go and change all the other
> filesystems (are we?).

I don't know who John is but i sure hope we are not going to
go changing how working filesystems function.  It may be
technically correct to not update ctime but that doesn't
mean that it is incorrect to update it either.  It all
depends on the filesystem.  They aren't all the same.  We
have some that don't support symlinks or hardlinks or that
have or lack other features.

<OT>
There are change detections through timestamp (mtime) i am
concerned about.  As an rsync maintainer i worry about be
extended attributes or ACLs changing with no modifiable
timestamps being updated.  And, by the way, because you
cannot set ctime it doesn't qualify.  Then there is jfs
which i found did not update mtime when directories change
unless the block count changes, but that might have been
fixed already.
</OT>

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
