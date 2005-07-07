Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262305AbVGGWNy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262305AbVGGWNy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 18:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbVGGWLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 18:11:14 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:974 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262305AbVGGWJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 18:09:04 -0400
From: "Timothy R. Chavez" <tinytim@us.ibm.com>
Organization: IBM
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH] audit: file system auditing based on location and name
Date: Thu, 7 Jul 2005 17:08:31 -0500
User-Agent: KMail/1.8
Cc: Steve Grubb <sgrubb@redhat.com>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, linux-audit@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       David Woodhouse <dwmw2@infradead.org>,
       Mounir Bsaibes <mbsaibes@us.ibm.com>, Serge Hallyn <serue@us.ibm.com>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Klaus Weidner <klaus@atsec.com>, Chris Wright <chrisw@osdl.org>,
       Stephen Smalley <sds@tycho.nsa.gov>, Robert Love <rml@novell.com>,
       Christoph Hellwig <hch@infradead.org>,
       Daniel H Jones <danjones@us.ibm.com>, Amy Griffis <amy.griffis@hp.com>,
       Maneesh Soni <maneesh@in.ibm.com>
References: <1120668881.8328.1.camel@localhost> <200507071548.37996.sgrubb@redhat.com> <1120771909.3198.32.camel@laptopd505.fenrus.org>
In-Reply-To: <1120771909.3198.32.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-6"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507071708.32451.tinytim@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 07 July 2005 16:31, Arjan van de Ven wrote:
> On Thu, 2005-07-07 at 15:48 -0400, Steve Grubb wrote:
> 
> > Tim's code lets you say I want change notification to this file only. The 
> > notification follows the audit format with all relavant pieces of information 
> > gathered at the time of the event and serialized with all other events.
> 
> well can't you sort of do that based on (selinux) security context of
> the file already? after all that's part of the inode already. Isn't that
> finegrained enough?
> 

Provided you make it that far, yes, SE Linux _could_ be used to provide
similar functionality.  But, what if you bottom out on a DAC decision?

[foo@liltux /]$ cat /etc/shadow
cat: /etc/shadow: Permission denied

-tim
