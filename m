Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262040AbUKPQl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbUKPQl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 11:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262027AbUKPQju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 11:39:50 -0500
Received: from mail.kroah.org ([69.55.234.183]:27861 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262020AbUKPQgv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 11:36:51 -0500
Date: Tue, 16 Nov 2004 08:33:14 -0800
From: Greg KH <greg@kroah.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: rcpt-linux-fsdevel.AT.vger.kernel.org@jankratochvil.net,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041116163314.GA6264@kroah.com>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 16, 2004 at 03:01:10PM +0100, Miklos Szeredi wrote:
> > "fuse/version" you have in /proc while it belongs to /proc
> > "fuse/dev"     you have in /proc while it belongs to /dev
> 
> Well, 'Documentation/devices.txt' says:
> 
>   THE DEVICE REGISTRY IS OFFICIALLY FROZEN FOR LINUS TORVALDS' KERNEL
>   TREE.  At Linus' request, no more allocations will be made official
>   for Linus' kernel tree; the 3 June 2001 version of this list is the
>   official final version of this registry.

Not true, you can get new numbers.

Don't put things that should be in /dev into /proc, not allowed.

> So placing it in /proc doesn't seem to me such a bad idea.

No.  Actually, put it in sysfs, and then udev will create your /dev node
for you automatically.  And in sysfs you can put your other stuff
(version, etc.) which is the proper place for it.

thanks,

greg k-h
