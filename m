Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbTJOTz4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 15:55:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264251AbTJOTz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 15:55:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55430 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264248AbTJOTzz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 15:55:55 -0400
Date: Wed, 15 Oct 2003 20:55:53 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Rohland <cr@sap.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tmpfs 2/7 LTP S_ISGID dir
Message-ID: <20031015195553.GU7665@parcelfarce.linux.theplanet.co.uk>
References: <20031015193404.GT7665@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.44.0310152046250.6969-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310152046250.6969-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 15, 2003 at 08:48:59PM +0100, Hugh Dickins wrote:
> On Wed, 15 Oct 2003 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Wed, Oct 15, 2003 at 07:19:46PM +0100, Hugh Dickins wrote:
> > > LTP tests the filesystem on /tmp: many failures when tmpfs because
> > > it missed the way giddy directories hand down their gid.  Also fix
> > > ramfs and hugetlbfs.
> > 
> > *the* way?  I can think of at least two...
> 
> You mean, the way they do directories and the way they do non-directories?
> Or, the way they do it if they do it, and the way they do it if they don't?
> Or something else?  Please, share your thought!

"We always inherit parents gid, sgid is ignored" and "we do that only
if parent is sgid and children that happen to be directories inherit
sgid from parent".  Yes, ramfs et.al. follow neither of those, but which
way to change that is an interesting question...
