Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbTIKV4O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 17:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbTIKVxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 17:53:52 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:46550 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261570AbTIKVwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 17:52:21 -0400
Date: Thu, 11 Sep 2003 23:52:16 +0200
From: Jens Axboe <axboe@suse.de>
To: Gerhard Mack <gmack@innerfire.net>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Andrew Morton <akpm@osdl.org>,
       Mike Fedyk <mfedyk@matchmail.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
Message-ID: <20030911215216.GM12021@suse.de>
References: <20030911082057.GP1396@suse.de> <Pine.LNX.4.44.0309111111150.24179-100000@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0309111111150.24179-100000@innerfire.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11 2003, Gerhard Mack wrote:
> On Thu, 11 Sep 2003, Jens Axboe wrote:
> 
> > On Wed, Sep 10 2003, Martin J. Bligh wrote:
> > > That's a real shame ... it seemed to work fine until recently. Some
> > > of the DVD writers (eg the one I have - Sony DRU500A or whatever)
> >
> > Then maybe it would be a really good idea to find out why it doesn't
> > work with ide-cd. What are the symptoms?
> >
> > > need it. Is it unfixable? or just nobody's done it?
> >
> > It's not unfixable, there's just not a lot of motivation to fix it since
> > it's basically dead.
> >
> 
> What about backwards compatability with all of that cd burning software
> out there that only knows to scan the SCSI devices?

That's basically impossible, I don't want to shoe horn atapi numbering
into faked bus,id,lun type things.

So people will just have to get used to the change. And I bet that Joe
user with his cd-r thinks it's a lot more intuitive to use dev=/dev/hdc
(which is his burner) rather than dev=1,0,0 for instance. The scanning
basically helps that case alone, because noone can guess these numbers.

-- 
Jens Axboe

