Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTKZUYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 15:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbTKZUYT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 15:24:19 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:14587 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264312AbTKZUYO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 15:24:14 -0500
Date: Wed, 26 Nov 2003 15:23:52 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: Nick Clifton <nickc@redhat.com>
Cc: torvalds@osdl.org, pavel@suse.cz, axboe@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: ionice kills vanilla 2.6.0-test9 was [Re: [PATCH] cfq + io priorities (fwd)]
Message-ID: <20031126202351.GA3017@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <Pine.LNX.4.44.0311211455510.13789-100000@home.osdl.org> <m3ptfehp3r.fsf@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m3ptfehp3r.fsf@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 08:06:00PM +0000, Nick Clifton wrote:
> Hi Linus,
> 
> > You can trivially see if with a simple assembly file like
> >
> > 	start:
> > 		.long 1,2,3,a
> > 	a=(.-start)/4
> >
> > where 2.13.90 as shipped by SuSE will get it right (and generate a
> > list of 1,2,3,4), while 2.14.90 from Fedora core will generate
> > 1,2,3,16.
> 
> It appears that the 2.14.90.0.6 release of binutils used with the
> Fedora code needs the patch below applied.  This patch has been
> committed to the 2_14 branch and the mainline binutils sources.

That's not the only change needed.
https://www.redhat.com/archives/fedora-test-list/2003-November/msg01380.html

	Jakub
