Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263214AbUDUPBz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbUDUPBz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 11:01:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263164AbUDUPBw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 11:01:52 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:40711 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263281AbUDUO4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 10:56:41 -0400
Date: Wed, 21 Apr 2004 15:56:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: raven@themaw.net
Cc: Andrew Morton <akpm@osdl.org>, viro@parcelfarce.linux.theplanet.co.uk,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc1-mm1
Message-ID: <20040421155634.A6736@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, raven@themaw.net,
	Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	linux-kernel@vger.kernel.org
References: <20040418230131.285aa8ae.akpm@osdl.org> <20040419202538.A15701@infradead.org> <Pine.LNX.4.58.0404200911090.12229@wombat.indigo.net.au> <20040419182657.7870aee9.akpm@osdl.org> <20040421100835.A3577@infradead.org> <Pine.LNX.4.58.0404212035280.3740@donald.themaw.net> <20040421141901.B5551@infradead.org> <Pine.LNX.4.58.0404212135520.3740@donald.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.58.0404212135520.3740@donald.themaw.net>; from raven@themaw.net on Wed, Apr 21, 2004 at 09:52:01PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2004 at 09:52:01PM +0800, raven@themaw.net wrote:
> > On Wed, Apr 21, 2004 at 08:39:59PM +0800, raven@themaw.net wrote:
> > > While I understand the motive for not exporting the lock the question of 
> > > how one should obtain vfsmount structs when needed remains?
> > 
> > You shouldn't.
> > 
> 
> Shouldn't need them?

Exactly.

> But your point is that they shouldn't need to be used and an different 
> design is should be used, right.
> 
> Could make life hard for the automounter.
> Possibly somewhat harder to solve the remaining limitations of autofs.
> But I haven't got a clear enough picture of what's needed yet (still).
> 
> I guess your point is that these services should reside in the VFS proper?

If you ask me much of what autofs does should reside in the VFS, namely
triggering userspace upcalls as soon someone enters a special trigger
(aka delayed mountpount) directory and expiry of vfsmounts.

