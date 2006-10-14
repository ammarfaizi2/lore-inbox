Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbWJNRme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbWJNRme (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Oct 2006 13:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030359AbWJNRme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Oct 2006 13:42:34 -0400
Received: from mail.kroah.org ([69.55.234.183]:30422 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030363AbWJNRmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Oct 2006 13:42:33 -0400
Date: Sat, 14 Oct 2006 01:01:07 -0700
From: Greg KH <greg@kroah.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Joel Becker <Joel.Becker@oracle.com>,
       ckrm-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Allow more than PAGESIZE data read in configfs
Message-ID: <20061014080107.GB19325@kroah.com>
References: <20061010182043.20990.83892.sendpatchset@localhost.localdomain> <20061010203511.GF7911@ca-server1.us.oracle.com> <20061011131935.448a8696.akpm@osdl.org> <20061011221822.GD7911@ca-server1.us.oracle.com> <20061011154836.9befa359.akpm@osdl.org> <1160609233.6389.82.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160609233.6389.82.camel@linuxchandra>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 04:27:13PM -0700, Chandra Seetharaman wrote:
> On Wed, 2006-10-11 at 15:48 -0700, Andrew Morton wrote:
> > On Wed, 11 Oct 2006 15:18:22 -0700
> > Joel Becker <Joel.Becker@oracle.com> wrote:
> > 
> > > On Wed, Oct 11, 2006 at 01:19:35PM -0700, Andrew Morton wrote:
> > > > The patch deletes a pile of custom code from configfs and replaces it with
> > > > calls to standard kernel infrastructure and fixes a shortcoming/bug in the
> > > > process.  Migration over to the new interface is trivial and almost
> > > > scriptable.
> > > 
> > > 	The configfs stuff is based on the sysfs code too.  Should we
> > > migrate sysfs/file.c to the same seq_file code?  Serious question, if
> > > the cleanup is considered better.
> > > 
> > 
> > I don't see why not.  I don't know if anyone has though of/proposed it
> > before.
> 
> I can generate a patch for that too.

Argh!!!!

Are you going to honestly tell me you have a single attribute in sysfs
that is larger than PAGE_SIZE?  If you are getting anywhere close to
this, then something is really wrong and we need to talk.

greg k-h
