Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261491AbVALWJQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261491AbVALWJQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 17:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261468AbVALWIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 17:08:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5014 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261491AbVALWCX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 17:02:23 -0500
Date: Wed, 12 Jan 2005 17:01:43 -0500
From: Dave Jones <davej@redhat.com>
To: Greg KH <greg@kroah.com>
Cc: Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
       openib-general@openib.org
Subject: Re: debugfs directory structure
Message-ID: <20050112220142.GO24518@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Greg KH <greg@kroah.com>,
	Roland Dreier <roland@topspin.com>, linux-kernel@vger.kernel.org,
	openib-general@openib.org
References: <52d5watlqs.fsf@topspin.com> <20050112210945.GN24518@redhat.com> <20050112214108.GA13801@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050112214108.GA13801@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2005 at 01:41:08PM -0800, Greg KH wrote:
 > On Wed, Jan 12, 2005 at 04:09:45PM -0500, Dave Jones wrote:
 > > On Wed, Jan 12, 2005 at 12:50:51PM -0800, Roland Dreier wrote:
 > >  > Hi Greg,
 > >  > 
 > >  > Now that debugfs is merged into Linus's tree, I'm looking at using it
 > >  > to replace the IPoIB debugging pseudo-filesystem (ipoib_debugfs).  Is
 > >  > there any guidance on what the structure of debugfs should look like?
 > >  > Right now I'm planning on putting all the debug info files under an
 > >  > ipoib/ top level directory.  Does that sound reasonable?
 > > 
 > > How about mirroring the toplevel kernel source structure ?
 > > 
 > > Ie, you'd make drivers/infiniband/ulp/ipoib ?
 > 
 > But who would be in charge of createing the "drivers/" subdirectory?
 > debugfs can't handle "/" in a directory name, like procfs does.

maybe it should ?

 > > It could get ugly quickly without some structure at least to
 > > the toplevel dir.
 > I say ipoib/ is fine, remember, this is for debugging stuff, it will
 > quickly get ugly anyway :)

with no heirarchy, what happens when two drivers want to make
the same directory / filenames ?

		Dave

