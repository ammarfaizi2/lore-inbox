Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262034AbULVUdc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262034AbULVUdc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 15:33:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbULVUdc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 15:33:32 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24506 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262034AbULVUda
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 15:33:30 -0500
Date: Wed, 22 Dec 2004 20:33:29 +0000
From: Matthew Wilcox <matthew@wil.cx>
To: Patrick Gefre <pfg@sgi.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       matthew@wil.cx
Subject: Re: [PATCH] 2.6.10 Altix : ioc4 serial driver support
Message-ID: <20041222203329.GO31261@parcelfarce.linux.theplanet.co.uk>
References: <200412220028.iBM0SB3d299993@fsgi900.americas.sgi.com> <20041222134423.GA11750@infradead.org> <41C9D0B8.9000208@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41C9D0B8.9000208@sgi.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2004 at 01:53:28PM -0600, Patrick Gefre wrote:
> Christoph Hellwig wrote:
> >So both claim the same PCI ID?  In this case you need to creat a small
> >shim driver that exports a pseudo-bus to the serial and ide driver using
> >the driver model.  You must never return an error from ->probe if you
> >actually use that particular device.
> 
> Has this been done before ? Any example I can use ??

drivers/parisc/superio.c does something similar.  I'm not sure I'd hold
it up as a shining example of how to write a driver ... constructive
criticism welcomed, thought there's some outstanding changes still in
the parisc tree that need to go upstream.

> Why is that ? Seems if kmalloc returns a void * and the left side is not, a 
> casting is appropriate ?

void * is special and different.  This is exactly why it was invented, btw.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
