Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261522AbVGGSU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbVGGSU7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 14:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVGGSU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:20:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:62395 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261473AbVGGSU5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:20:57 -0400
Date: Thu, 7 Jul 2005 11:18:59 -0700
From: Greg KH <greg@kroah.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Timothy R. Chavez" <tinytim@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
       linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Mounir Bsaibes <mbsaibes@us.ibm.com>,
       Steve Grubb <sgrubb@redhat.com>, Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Message-ID: <20050707181859.GA14873@kroah.com>
References: <1120668881.8328.1.camel@localhost> <200507061523.11468.tinytim@us.ibm.com> <20050706235008.GA9985@kroah.com> <200507071126.52375.tinytim@us.ibm.com> <20050707181055.GA21072@kroah.com> <1120760195.8058.223.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120760195.8058.223.camel@baythorne.infradead.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 07, 2005 at 07:16:35PM +0100, David Woodhouse wrote:
> On Thu, 2005-07-07 at 11:10 -0700, Greg KH wrote:
> > Yes, and then I change namespaces to put /etc/shadow at
> > /foo/baz/etc/shadow and then access it that way?  Will the current
> > audit system fail to catch that access?
> 
> The watch is attached to the inode which you happened to call '/etc' in
> your namespace, and takes effect in _any_ namespace regardless of the
> path to it.
> 
> In the audit trail, you see the path which was used in the audited
> process's namespace, and also the filter key which was associated with
> that watch when you added it.

Ok, thanks, that makes sense.

greg k-h
