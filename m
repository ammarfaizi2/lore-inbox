Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265785AbUGDVfc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265785AbUGDVfc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 17:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265781AbUGDVfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 17:35:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30680 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265785AbUGDVf2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 17:35:28 -0400
Date: Sun, 4 Jul 2004 22:35:27 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andrew Morton <akpm@osdl.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       olaf+list.linux-kernel@olafdietsche.de
Subject: Re: procfs permissions on 2.6.x
Message-ID: <20040704213527.GV12308@parcelfarce.linux.theplanet.co.uk>
References: <20040703202242.GA31656@MAIL.13thfloor.at> <20040703202541.GA11398@infradead.org> <20040703133556.44b70d60.akpm@osdl.org> <20040703210407.GA11773@infradead.org> <20040703143558.5f2c06d6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040703143558.5f2c06d6.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 03, 2004 at 02:35:58PM -0700, Andrew Morton wrote:
> > Because it turns the question what permissions a procfs file has into
> > a lottery game.  He only changes the incore inode owner and as soon as
> > the inode is reclaimed the old ones return.
> 
> procfs inodes aren't reclaimable.

WTF do you mean "not reclaimable"?  They do get freed under memory pressure
and recreated on later lookups.
