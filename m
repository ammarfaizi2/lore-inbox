Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVGGW4r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVGGW4r (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 18:56:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262390AbVGGWyM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 18:54:12 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:33207 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262428AbVGGWwm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 18:52:42 -0400
Date: Thu, 7 Jul 2005 17:51:36 -0500
From: serue@us.ibm.com
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: Arjan van de Ven <arjan@infradead.org>, Steve Grubb <sgrubb@redhat.com>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       linux-audit@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Message-ID: <20050707225136.GA27099@serge.austin.ibm.com>
References: <1120668881.8328.1.camel@localhost> <200507071548.37996.sgrubb@redhat.com> <1120771909.3198.32.camel@laptopd505.fenrus.org> <200507071708.32451.tinytim@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200507071708.32451.tinytim@us.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Timothy R. Chavez (tinytim@us.ibm.com):
> On Thursday 07 July 2005 16:31, Arjan van de Ven wrote:
> > On Thu, 2005-07-07 at 15:48 -0400, Steve Grubb wrote:
> > 
> > > Tim's code lets you say I want change notification to this file only. The 
> > > notification follows the audit format with all relavant pieces of information 
> > > gathered at the time of the event and serialized with all other events.
> > 
> > well can't you sort of do that based on (selinux) security context of
> > the file already? after all that's part of the inode already. Isn't that
> > finegrained enough?
> > 
> 
> Provided you make it that far, yes, SE Linux _could_ be used to provide
> similar functionality.  But, what if you bottom out on a DAC decision?
> 
> [foo@liltux /]$ cat /etc/shadow
> cat: /etc/shadow: Permission denied

Additionally, the apps would need to either be rewritten to create
the files under the audited context, or policy would have to cause all
files created by those apps to be under the audited context.  Neither
one of those options is satisfactory.

thanks,
-serge
