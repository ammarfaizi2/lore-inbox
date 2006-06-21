Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751569AbWFUNMR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751569AbWFUNMR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 09:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751572AbWFUNMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 09:12:17 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:64261 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S1751564AbWFUNMQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 09:12:16 -0400
Date: Wed, 21 Jun 2006 21:05:40 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Al Viro <viro@ftp.linux.org.uk>
cc: akpm@osdl.org, autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] autofs4 needs to force fail return revalidate
In-Reply-To: <20060621122523.GX27946@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0606212103080.14481@raven.themaw.net>
References: <200606210618.k5L6IFDr008176@raven.themaw.net>
 <20060621122523.GX27946@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-themaw-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-2.599,
	required 5, autolearn=not spam, BAYES_00 -2.60)
X-themaw-MailScanner-From: raven@themaw.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Al Viro wrote:

> On Wed, Jun 21, 2006 at 02:18:15PM +0800, Ian Kent wrote:
> > While this problem has been present for a long time I've avoided resolving 
> > it because it was not very visible. But now that autofs v5 has "mount and 
> > expire on demand" of nested multiple mounts, such as is found when 
> > mounting an export list from a server, solving the problem cannot be 
> > avoided any longer.
> > 
> > I've tried very hard to find a way to do this entirely within the 
> > autofs4 module but have not been able to find a satisfactory way to 
> > achieve it.
> > 
> > So, I need to propose a change to the VFS.
> 
> NAK in that form.  Care to explain what should happen to mount tree
> when you do that to mountpoint?
> 

The flag is never set if it a mount succeeds so there's never a tree under 
it. But that's only my usage, so point taken.

Thinking about it that's not the only potential problem either.

Ian

