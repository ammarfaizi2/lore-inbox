Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbWCVQyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbWCVQyv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 11:54:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWCVQyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 11:54:51 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:62102 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751387AbWCVQyu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 11:54:50 -0500
Date: Wed, 22 Mar 2006 16:54:44 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
       virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>
Subject: Re: [RFC PATCH 35/35] Add Xen virtual block device driver.
Message-ID: <20060322165444.GA16291@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Anthony Liguori <aliguori@us.ibm.com>,
	Chris Wright <chrisw@sous-sol.org>, linux-kernel@vger.kernel.org,
	virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
	Ian Pratt <ian.pratt@xensource.com>
References: <20060322063040.960068000@sorel.sous-sol.org> <20060322063809.005748000@sorel.sous-sol.org> <44217DBD.8030201@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44217DBD.8030201@us.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2006 at 10:39:25AM -0600, Anthony Liguori wrote:
> This is another thing that has always put me off.  The virtual block 
> device driver has the ability to masquerade as other types of block 
> devices.  It actually claims to be an IDE or SCSI device allocating the 
> appropriate major/minor numbers.
> 
> This seems to be pretty evil and creating interesting failure conditions 
> for users who load IDE or SCSI modules.  I've seen it trip up a number 
> of people in the past.  I think we should only ever use the major number 
> that was actually allocated to us.

Exactly.  We vetoed crap like that in the ibm vio drivers already so
it was removed before merging those drivers.

