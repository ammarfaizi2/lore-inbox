Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266993AbUBFXVE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 18:21:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266997AbUBFXVD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 18:21:03 -0500
Received: from mail.shareable.org ([81.29.64.88]:15312 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266993AbUBFXU6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 18:20:58 -0500
Date: Fri, 6 Feb 2004 23:20:43 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Greg KH <greg@kroah.com>
Cc: "Woodruff, Robert J" <woody@co.intel.com>,
       "King, Steven R" <steven.r.king@intel.com>,
       linux-kernel@vger.kernel.org, infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Message-ID: <20040206232043.GC12503@mail.shareable.org>
References: <F595A0622682C44DBBE0BBA91E56A5ED1C3682@orsmsx410.jf.intel.com> <20040205215401.GE15718@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040205215401.GE15718@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> > Are there any other examples of drivers that isolate kernel specific
> > calls to one module or file of their code to ease portability between
> > different revisions of the kernel ? If not, maybe they should look at
> > what we have done, it might save them some headaches in the future. 
> 
> No, that is not how Linux kernel development is done.  Come on people,
> do your research...

To clarify:

For out-of-tree 3rd party drivers, there are two or three
"compatibility" packages which are used to allow a single driver
source to work with many kernel versions.  (I wrote one, it is used
for quite a few private drivers.  This method works well.  See
also "kcompat").

For drivers in the kernel tree, or drivers that somone would like to
go into the tree, "compatibility" headers are never used.  API changes
are for good reasons; drivers need to be updated to follow them.

When the kernel APIs change, for minor changes and sometimes even
major ones, the author of the API change will often go through all the
in tree drivers making the necessary changes.

-- Jamie
