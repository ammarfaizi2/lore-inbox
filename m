Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262452AbVDXVnv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262452AbVDXVnv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 17:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVDXVnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 17:43:50 -0400
Received: from mail.shareable.org ([81.29.64.88]:8872 "EHLO mail.shareable.org")
	by vger.kernel.org with ESMTP id S262449AbVDXVnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 17:43:47 -0400
Date: Sun, 24 Apr 2005 22:43:39 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050424214339.GD9304@mail.shareable.org>
References: <E1DPnOn-0000T0-00@localhost> <20050424201820.GA28428@infradead.org> <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <E1DPoRz-0000Y0-00@localhost> <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050424211942.GN13052@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Al Viro wrote:
> On Sun, Apr 24, 2005 at 11:15:35PM +0200, Miklos Szeredi wrote:
> > No.  You can't set "mount environment" in scp.
> 
> Of course you can.  It does execute the obvious set of rc files.

It doesn't work for the specified use-scenario.  The reason is that
there is no command or system call that can be executed from those rc
files to join an existing namespace.

He wants to do this:

   1. From client, login to server and do a usermount on $HOME/private.

   2. From client, login to server and read the files previously mounted.

-- Jamie
