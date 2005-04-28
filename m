Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262241AbVD1TX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVD1TX0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 15:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262243AbVD1TXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 15:23:13 -0400
Received: from mail.shareable.org ([81.29.64.88]:42154 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262241AbVD1TWf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 15:22:35 -0400
Date: Thu, 28 Apr 2005 20:22:23 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Pavel Machek <pavel@ucw.cz>,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Miklos Szeredi <miklos@szeredi.hu>, hch@infradead.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050428192223.GB2895@mail.shareable.org>
References: <E1DPo3I-0000V0-00@localhost> <20050424205422.GK13052@parcelfarce.linux.theplanet.co.uk> <E1DPoCg-0000W0-00@localhost> <20050424210616.GM13052@parcelfarce.linux.theplanet.co.uk> <20050424213822.GB9304@mail.shareable.org> <20050425152049.GB2508@elf.ucw.cz> <20050425190734.GB28294@mail.shareable.org> <20050426092924.GA4175@elf.ucw.cz> <20050426140715.GA10833@mail.shareable.org> <a4e6962a050428062821838bcb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e6962a050428062821838bcb@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Van Hensbergen wrote:
> > Does chroot into /proc/NNN/root cause the chroot'ing process to adopt
> > the namespace of NNN?  Looking at the code, I think it does.
> 
> I've been thinking about this a bit more...would you even need chroot?
> (wouldn't exposing chroot functionality to a user incur additional
> security risk?  I guess it would be okay as long as you were only
> chrooting to one of your other process' roots?)

You don't need to let an ordinary user do chroot.

The login process can do it before it changes uid to the user, the
same as it does to set up all the other per-user parameters.

-- Jamie
