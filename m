Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751971AbWCBIyY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751971AbWCBIyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 03:54:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751972AbWCBIyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 03:54:24 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:33187 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751971AbWCBIyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 03:54:23 -0500
Date: Thu, 2 Mar 2006 08:54:16 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Christoph Hellwig <hch@infradead.org>, Sam Vilain <sam@vilain.net>,
       David Howells <dhowells@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: [PATCH 1/5] NFS: Permit filesystem to override root dentry on mount [try #2]]
Message-ID: <20060302085416.GW27946@ftp.linux.org.uk>
References: <44061705.9020105@vilain.net> <20060302084522.GB21902@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060302084522.GB21902@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 02, 2006 at 08:45:22AM +0000, Christoph Hellwig wrote:
> On Thu, Mar 02, 2006 at 10:49:57AM +1300, Sam Vilain wrote:
> > The attached patch extends the get_sb() filesystem operation to take an 
> > extra argument that permits the VFS to pass in the target vfsmount that 
> > defines the mountpoint.
> 
> NACK.  Filesystem has not business at all to look at the vfsmount during
> mount.

There's nothing to look _at_.  There is an object to be filled.
