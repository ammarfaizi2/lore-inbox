Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262590AbVAPTmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262590AbVAPTmW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 14:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbVAPTmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 14:42:21 -0500
Received: from mail.mellanox.co.il ([194.90.237.34]:6870 "EHLO
	mtlex01.yok.mtl.com") by vger.kernel.org with ESMTP id S262590AbVAPTmL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 14:42:11 -0500
Date: Sun, 16 Jan 2005 21:42:26 +0200
From: "Michael S. Tsirkin" <mst@mellanox.co.il>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: changing local version requires full rebuild
Message-ID: <20050116194226.GA5276@mellanox.co.il>
Reply-To: "Michael S. Tsirkin" <mst@mellanox.co.il>
References: <20050116152242.GA4537@mellanox.co.il> <20050116161622.GC3090@mars.ravnborg.org> <20050116162816.GA4715@mellanox.co.il> <20050116172647.GA3306@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050116172647.GA3306@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!
Quoting r. Sam Ravnborg (sam@ravnborg.org) "Re: changing local version requires full rebuild":
>  > 
> > > Do you use "echo -mylocalver > localversion" to change the local version?
> > > 
> > > 	Sam
> > 
> > No, I do makemenuconfig to edit the version. Is that right?
> 
> That is fine too.
> When building - do you use separate output dir?
> 
> 	Sam

First, by design any module includes the full
kernel release name as part of the VERMAGIC_STRING.
So at least one file will have to be rebuilt for each module,
and all modules have to be relinked, if localversion changes.


MST
