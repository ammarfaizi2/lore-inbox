Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264298AbTJOU3A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 16:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbTJOU2z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 16:28:55 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:52835 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id S264298AbTJOU2x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 16:28:53 -0400
Date: Wed, 15 Oct 2003 21:18:40 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: viro@parcelfarce.linux.theplanet.co.uk
cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tmpfs 2/7 LTP S_ISGID dir
In-Reply-To: <20031015195553.GU7665@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.44.0310152112210.7007-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Oct 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Wed, Oct 15, 2003 at 08:48:59PM +0100, Hugh Dickins wrote:
> > On Wed, 15 Oct 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > > On Wed, Oct 15, 2003 at 07:19:46PM +0100, Hugh Dickins wrote:
> > > > LTP tests the filesystem on /tmp: many failures when tmpfs because
> > > > it missed the way giddy directories hand down their gid.  Also fix
> > > > ramfs and hugetlbfs.
> > > 
> > > *the* way?  I can think of at least two...
> > 
> > You mean, the way they do directories and the way they do non-directories?
> > Or, the way they do it if they do it, and the way they do it if they don't?
> > Or something else?  Please, share your thought!
> 
> "We always inherit parents gid, sgid is ignored" and "we do that only
> if parent is sgid and children that happen to be directories inherit
> sgid from parent".  Yes, ramfs et.al. follow neither of those, but which
> way to change that is an interesting question...

The patch chooses the second, which I see as merely fixing an oversight
(in the exceptional S_ISGID case); to choose the first convention would
be a significant change in behaviour (or a feature request for the option).

Hugh

