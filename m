Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbVGKROl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbVGKROl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 13:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVGKROi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:14:38 -0400
Received: from mail.kroah.org ([69.55.234.183]:20392 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262238AbVGKROP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:14:15 -0400
Date: Mon, 11 Jul 2005 10:13:40 -0700
From: Greg KH <greg@kroah.com>
To: Michael C Thompson <mcthomps@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, Daniel H Jones <danjones@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Christoph Hellwig <hch@infradead.org>, linux-audit@redhat.com,
       linux-audit-bounces@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Maneesh Soni <maneesh@in.ibm.com>,
       Robert Love <rml@novell.com>, tinytim@us.ibm.com,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Message-ID: <20050711171340.GA30895@kroah.com>
References: <20050710185954.GB18639@kroah.com> <OF993CB74B.E135A576-ON8725703B.00568CD6-0525703B.005814C3@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF993CB74B.E135A576-ON8725703B.00568CD6-0525703B.005814C3@us.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2005 at 11:07:17AM -0500, Michael C Thompson wrote:
> > > Ultimately, the part where we differ most, is the processing of information in
> > > fs/dcache.c to give dynamic updates in response to file system activity (such
> > > as attaching audit information to an auditable file whose inode just changed).
> > > I believe this should be kept seperate and not part of this framework nor Inotify.
> > > It's a specific requirement for audit, but not for Inotify.  This is one of the places
> > > the two systems are functionally different.
> >
> > I don't think it should be different.  If inotify wants to just ignore
> > this information, it can.
> 
> Doesn't this mentality bring with it the risk of bloating a framework that
> should be as "trim" as possible?

vs. the mentality that since you are doing something just a bit
different, you should duplicate lots of other functionality too?  no.

greg k-h
