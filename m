Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751021AbVKARcz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbVKARcz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 12:32:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751019AbVKARcz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 12:32:55 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:32472
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751022AbVKARcz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 12:32:55 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Evgeny Stambulchik <Evgeny.Stambulchik@weizmann.ac.il>
Subject: Re: [PATCH] fix floppy.c to store correct ro/rw status in underlying gendisk
Date: Tue, 1 Nov 2005 11:32:49 -0600
User-Agent: KMail/1.8
Cc: jonathan@jonmasters.org, linux-kernel@vger.kernel.org
References: <4363B081.7050300@jonmasters.org> <200510311717.21676.rob@landley.net> <4367734E.6050600@weizmann.ac.il>
In-Reply-To: <4367734E.6050600@weizmann.ac.il>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511011132.49962.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 01 November 2005 07:53, Evgeny Stambulchik wrote:
> Rob Landley wrote:
> > But yeah, we're sticklers for correct behavior, and only attempt to
> > remount readonly if we get EACCES or EROFS, not _just_ because we
> > attempted a read/write mount and it failed.
>
> BTW, busybox doesn't agree to do just mount -o remount,... /mountpoint,
> it wants also either the device name passed or the entry be present in
> fstab.

Did you try the -devel version or 1.01?  (I did about an 80% rewrite of this 
sucker after 1.0, but it hasn't shipped yet.  I bounced a 1.1.0-pre1 tarball 
off of Erik and he said he'd put it up today, meanwhile grab the subversion 
snapshot.)

Busybox -devel is way ahead of 1.01.  Hopefully we'll have a new -stable 
release by the end of the year...

Rob
