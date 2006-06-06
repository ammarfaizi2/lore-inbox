Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWFFLBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWFFLBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 07:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWFFLBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 07:01:09 -0400
Received: from mail-gw2.sa.eol.hu ([212.108.200.109]:62852 "EHLO
	mail-gw2.sa.eol.hu") by vger.kernel.org with ESMTP id S1751151AbWFFLBH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 07:01:07 -0400
To: James.Bottomley@steeleye.com
CC: rmk+lkml@arm.linux.org.uk, htejun@gmail.com, axboe@suse.de,
       davem@redhat.com, bzolnier@gmail.com, james.steward@dynamicratings.com,
       jgarzik@pobox.com, mattjreimer@gmail.com, g.liakhovetski@gmx.de,
       linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
In-reply-to: <1149515032.3489.4.camel@mulgrave.il.steeleye.com> (message from
	James Bottomley on Mon, 05 Jun 2006 08:43:52 -0500)
Subject: Re: [PATCHSET] block: fix PIO cache coherency bug, take 2
References: <1149392479501-git-send-email-htejun@gmail.com>
	 <20060604204444.GF4484@flint.arm.linux.org.uk> <1149515032.3489.4.camel@mulgrave.il.steeleye.com>
Message-Id: <E1FnZI8-0003u0-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 06 Jun 2006 13:00:08 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > I tried to implement flush_anon_page() too but didn't know what to
> > do
> > > with anon_vma object.
> > 
> > I'm not sure what this is about...
> 
> This was for fuse on parisc.

I have reports that this effects some ARM architectures as well.

And direct I/O over NFS and a couple other things which also use the
get_user_pages() mechanism will also not work properly without
flush_anon_page().

Miklos
