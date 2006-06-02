Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbWFBInd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbWFBInd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 04:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWFBInd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 04:43:33 -0400
Received: from cantor2.suse.de ([195.135.220.15]:16006 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751228AbWFBInd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 04:43:33 -0400
Date: Fri, 2 Jun 2006 10:43:27 +0200
From: Olaf Hering <olh@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, viro@ftp.linux.org.uk
Subject: Re: [PATCH] cramfs corruption after BLKFLSBUF on loop device
Message-ID: <20060602084327.GA3964@suse.de>
References: <20060529214011.GA417@suse.de> <20060530182453.GA8701@suse.de> <20060601184938.GA31376@suse.de> <20060601121200.457c0335.akpm@osdl.org> <20060601201050.GA32221@suse.de> <20060601142400.1352f903.akpm@osdl.org> <20060601214158.GA438@suse.de> <20060601145747.274df976.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060601145747.274df976.akpm@osdl.org>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Thu, Jun 01, Andrew Morton wrote:


> > Do you want it like that?
> > 
> > lock_page(page);
> > if (PageUptodate(page)) {
> >         SetPageDirty(page);
> >         mb();
> >         return page;
> > }
> 
> Not really ;)  It's hacky.  It'd be better to take a lock.

Which lock exactly? I'm not sure how to proceed from here.
