Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWF1PCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWF1PCk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 11:02:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751291AbWF1PCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 11:02:40 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.144]:61876 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751070AbWF1PCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 11:02:39 -0400
Date: Wed, 28 Jun 2006 10:01:42 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Al Viro <viro@ftp.linux.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org, serue@us.ibm.com
Subject: Re: [PATCH 20/20] honor r/w changes at do_remount() time
Message-ID: <20060628150142.GA17543@sergelap.austin.ibm.com>
References: <20060627221436.77CCB048@localhost.localdomain> <20060627221457.04ADBF71@localhost.localdomain> <20060628051935.GA29920@ftp.linux.org.uk> <20060628144104.GE5572@MAIL.13thfloor.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060628144104.GE5572@MAIL.13thfloor.at>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Herbert Poetzl (herbert@13thfloor.at):
> On Wed, Jun 28, 2006 at 06:19:35AM +0100, Al Viro wrote:
> > On Tue, Jun 27, 2006 at 03:14:57PM -0700, Dave Hansen wrote:
> > > 
> > > Originally from: Herbert Poetzl <herbert@13thfloor.at>
> > > 
> > > This is the core of the read-only bind mount patch set.
> > > 
> > > Note that this does _not_ add a "ro" option directly to
> > > the bind mount operation.  If you require such a mount,
> > > you must first do the bind, then follow it up with a
> > > 'mount -o remount,ro' operation.
> >  
> > I guess the fundamental problem I have with that approach is that it's
> > a cop-out - we just declare rw state of vfsmount independent from that
> > of filesystem and add a "if a flag is set, act upon vfsmount".
> 
> IMHO the read only check has to be done twice, i.e
> once for the superblock and a second time for the
> particular vfs mount, similar, the procfs mounts
> entry shows the combination (logical and) of the
> write ability ...

Shouldn't the vfsmount rw flag being set imply superblock rw?

-serge
