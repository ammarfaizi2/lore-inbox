Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264654AbUDVT6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264654AbUDVT6h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 15:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264653AbUDVT4I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 15:56:08 -0400
Received: from fw.osdl.org ([65.172.181.6]:4324 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264654AbUDVTxT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 15:53:19 -0400
Date: Thu, 22 Apr 2004 12:53:17 -0700
From: Chris Wright <chrisw@osdl.org>
To: =?iso-8859-1?Q?Peter_W=E4chtler?= <pwaechtler@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] coredump - as root not only if euid switched
Message-ID: <20040422125317.Q22989@build.pdx.osdl.net>
References: <2899705.1082626850875.JavaMail.pwaechtler@mac.com> <20040422025638.0bf86599.akpm@osdl.org> <1082663036.2592.1.camel@picklock.adams.family>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <1082663036.2592.1.camel@picklock.adams.family>; from pwaechtler@mac.com on Thu, Apr 22, 2004 at 09:43:57PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Peter Wächtler (pwaechtler@mac.com) wrote:
> Am Do, 2004-04-22 um 11.56 schrieb Andrew Morton:
> > Peter Waechtler <pwaechtler@mac.com> wrote:
> > >
> > >  >(why are you trying to unlink the old file anyway?)
> > >  >
> > > 
> > >  For security measure :O
> > >  I tried on solaris: touch the core file as user, open it and wait, dump core
> > >  as root -> nope, couldn't read the damn core - it was unlinked and created!
> > 
> > hm, OK.  There's a window in which someone can come in and recreate the
> > file, but the open is using O_EXCL|O_CREATE so that seems safe enough.
> 
> So here is the updated patch with an open coded call to sys_unlink

This patch breaks various ptrace() checks.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
