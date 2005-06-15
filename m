Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbVFOWRX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbVFOWRX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 18:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVFOWRW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 18:17:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50406 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261648AbVFOWPE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 18:15:04 -0400
Date: Wed, 15 Jun 2005 15:14:51 -0700
From: Chris Wright <chrisw@osdl.org>
To: Greg KH <greg@kroah.com>
Cc: Reiner Sailer <sailer@watson.ibm.com>, LKML <linux-kernel@vger.kernel.org>,
       LSM <linux-security-module@wirex.com>, Tom Lendacky <toml@us.ibm.com>,
       Chris Wright <chrisw@osdl.org>, Emily Rattlif <emilyr@us.ibm.com>,
       Kylene Hall <kylene@us.ibm.com>
Subject: Re: [PATCH] 4 of 5 IMA: module measurement patch
Message-ID: <20050615221451.GR9046@shell0.pdx.osdl.net>
References: <1118847443.2269.22.camel@secureip.watson.ibm.com> <20050615215823.GA539@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615215823.GA539@kroah.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Greg KH (greg@kroah.com) wrote:
> On Wed, Jun 15, 2005 at 10:57:23AM -0400, Reiner Sailer wrote:
> > +extern int ima_terminating;
> > +extern void measure_kernel_module(void *start, unsigned long len, const char __user *uargs);
> 
> These belong in a .h file somewhere.

Well, I think they _are_ in a .h file (two of them, in fact), it's the
extern keyword that can be and dup declaration that can be dropped.
However, does this thing even compile w/ CONFIG_IMA_MEASURE=n?
Looks quite broken w.r.t. CONFIG_IMA_MEASURE to me.

thanks,
-chris
