Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261685AbUCSC6u (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 21:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261696AbUCSC6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 21:58:50 -0500
Received: from MAIL.13thfloor.at ([212.16.62.51]:14289 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S261685AbUCSC6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 21:58:49 -0500
Date: Fri, 19 Mar 2004 03:58:45 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: viro@parcelfarce.linux.theplanet.co.uk
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bind Mount Extensions 0.04 (linux-2.4.25)
Message-ID: <20040319025845.GD31040@MAIL.13thfloor.at>
Mail-Followup-To: viro@parcelfarce.linux.theplanet.co.uk,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20040315035559.GC30948@MAIL.13thfloor.at> <20040318122932.GK31500@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040318122932.GK31500@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2004 at 12:29:32PM +0000, viro@parcelfarce.linux.theplanet.co.uk wrote:
> On Mon, Mar 15, 2004 at 04:55:59AM +0100, Herbert Poetzl wrote:
> >  	if (count != 0) {
> > -		UPDATE_ATIME(file->f_dentry->d_inode);
> > +		UPDATE_ATIME(file->f_dentry->d_inode, file->f_vfsmnt);
> 
> For crying out loud...  Make that touch_file(file) and be done with that.
> There's a lot of places where we do just that (touch atime of opened file)
> and passing pair of vfsmount and inode (not even vfsmount and dentry) is
> just plain wrong.

I guess 2.4 will not allow to many changes in this regard, 
but maybe I'm wrong and deeper changes have a chance to
be accepted into mainline to 'mend' the 'broken' behaviour

best,
Herbert
