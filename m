Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261975AbVEQWEr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261975AbVEQWEr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 18:04:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVEQWDJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 18:03:09 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4737 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262008AbVEQVvu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 17:51:50 -0400
Date: Tue, 17 May 2005 14:51:37 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: =?UTF-8?B?UG96c8OhciBCYWzDoXpz?= <pozsy@uhulinux.hu>
Cc: bzolnier@elka.pw.edu.pl, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: Oops on CF removal and "convert device drivers to driver-model"
Message-Id: <20050517145137.6b91f242.zaitcev@redhat.com>
In-Reply-To: <20050517211704.GB7452@ojjektum.uhulinux.hu>
References: <20050514135019.0b3252f1.zaitcev@redhat.com>
	<20050517211704.GB7452@ojjektum.uhulinux.hu>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 1.9.9 (GTK+ 2.6.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 May 2005 23:17:04 +0200, Pozsár Balázs <pozsy@uhulinux.hu> wrote:

> On Sat, May 14, 2005 at 01:50:19PM -0700, Pete Zaitcev wrote:
> > @@ -1138,7 +1133,8 @@ static int idescsi_attach(ide_drive_t *d
> >  	idescsi->host = host;
> >  	idescsi->disk = g;
> >  	g->private_data = &idescsi->driver;
> > -	err = ide_register_subdriver(drive, &idescsi_driver);
> > +	ide_register_subdriver(drive, &idescsi_driver);
> > +	err = 0;
> >  	if (!err) {
> >  		idescsi_setup (drive, idescsi);
> >  		g->fops = &idescsi_ops;
> 
> !err cannot be true here, so this seems buggy.

Indeed.

Unfortunately, Andrew's scripts notified me that he added the patch to
his tree, so I'd need to wait for a turnaround before a fix-over-fix.

-- Pete
