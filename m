Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVGGSRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVGGSRN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 14:17:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbVGGSRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 14:17:01 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:60881 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S261542AbVGGSQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 14:16:47 -0400
Subject: Re: [PATCH] audit: file system auditing based on location and name
From: David Woodhouse <dwmw2@infradead.org>
To: Greg KH <greg@kroah.com>
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
In-Reply-To: <20050707181055.GA21072@kroah.com>
References: <1120668881.8328.1.camel@localhost>
	 <200507061523.11468.tinytim@us.ibm.com> <20050706235008.GA9985@kroah.com>
	 <200507071126.52375.tinytim@us.ibm.com>  <20050707181055.GA21072@kroah.com>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 19:16:35 +0100
Message-Id: <1120760195.8058.223.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-07 at 11:10 -0700, Greg KH wrote:
> Yes, and then I change namespaces to put /etc/shadow at
> /foo/baz/etc/shadow and then access it that way?  Will the current
> audit system fail to catch that access?

The watch is attached to the inode which you happened to call '/etc' in
your namespace, and takes effect in _any_ namespace regardless of the
path to it.

In the audit trail, you see the path which was used in the audited
process's namespace, and also the filter key which was associated with
that watch when you added it.

-- 
dwmw2


