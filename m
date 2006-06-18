Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932271AbWFRSgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932271AbWFRSgT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 14:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751218AbWFRSgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 14:36:19 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:3772 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751217AbWFRSgR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 14:36:17 -0400
Date: Sun, 18 Jun 2006 19:36:16 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       herbert@13thfloor.at
Subject: Re: [RFC][PATCH 20/20] honor r/w changes at do_remount() time
Message-ID: <20060618183616.GA27946@ftp.linux.org.uk>
References: <20060616231213.D4C5D6AF@localhost.localdomain> <20060616231228.2107A2EE@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060616231228.2107A2EE@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2006 at 04:12:28PM -0700, Dave Hansen wrote:
> 
> Originally from: Herbert Poetzl <herbert@13thfloor.at>
> 
> This is the core of the read-only bind mount patch set.
> 
> Note that this does _not_ add a "ro" option directly to
> the bind mount operation.  If you require such a mount,
> you must first do the bind, then follow it up with a
> 'mount -o remount,ro' operation.

Hrm...  So you want r/o status of vfsmount completely independent from
that of superblock?  I.e. allow writable vfsmount over r/o filesystem?
I realize that we have double checks, but...
