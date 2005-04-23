Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVDWT25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVDWT25 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 15:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261727AbVDWT24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 15:28:56 -0400
Received: from fire.osdl.org ([65.172.181.4]:42911 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261652AbVDWT2w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 15:28:52 -0400
Date: Sat, 23 Apr 2005 12:30:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Harkes <jaharkes@cs.cmu.edu>
cc: David Woodhouse <dwmw2@infradead.org>, Jan Dittmer <jdittmer@ppp0.net>,
       Greg KH <greg@kroah.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
Subject: Re: Git-commits mailing list feed.
In-Reply-To: <20050423183406.GD20410@delft.aura.cs.cmu.edu>
Message-ID: <Pine.LNX.4.58.0504231228480.2344@ppc970.osdl.org>
References: <200504210422.j3L4Mo8L021495@hera.kernel.org> <42674724.90005@ppp0.net>
 <20050422002922.GB6829@kroah.com> <426A4669.7080500@ppp0.net>
 <1114266083.3419.40.camel@localhost.localdomain> <426A5BFC.1020507@ppp0.net>
 <1114266907.3419.43.camel@localhost.localdomain> <Pine.LNX.4.58.0504231010580.2344@ppc970.osdl.org>
 <20050423183406.GD20410@delft.aura.cs.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Apr 2005, Jan Harkes wrote:
> 
> Why not keep the tags object outside of the tree in the tags/ directory.

Because then you have all those special cases with fetching them and with 
fsck, and with shared object directories. In other words: no. 

You can have symlinks (or even better, just a single file with all the
tags listed, which you can create with "fsck", for example) from the tags/
directory, but the thing is, objects go in the object directory and
nowhere else.

			Linus
