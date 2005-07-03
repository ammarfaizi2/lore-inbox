Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVGCAZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVGCAZS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 20:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVGCAZS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 20:25:18 -0400
Received: from ms-smtp-04.texas.rr.com ([24.93.47.43]:20684 "EHLO
	ms-smtp-04.texas.rr.com") by vger.kernel.org with ESMTP
	id S261336AbVGCAZM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 20:25:12 -0400
Date: Sat, 2 Jul 2005 19:24:41 -0500
From: serge@hallyn.com
To: Greg KH <greg@kroah.com>
Cc: serue@us.ibm.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [patch 5/12] lsm stacking v0.2: actual stacker module
Message-ID: <20050703002441.GA25052@vino.hallyn.com>
References: <20050630194458.GA23439@serge.austin.ibm.com> <20050630195043.GE23538@serge.austin.ibm.com> <20050701203526.GA824@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050701203526.GA824@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for all your comments.

Quoting Greg KH (greg@kroah.com):
> On Thu, Jun 30, 2005 at 02:50:43PM -0500, serue@us.ibm.com wrote:
> > +/* variables to hold kobject/sysfs data */
> > +static struct subsystem stacker_subsys;
> 
> Use decl_subsys please.
> 
> And yes, James is right, only value per sysfs file is allowed.

Hmm, I could instead have one file per loaded LSM, which could
obviate the need for the stacker/unload file, but that would make
it more work for a user to find the ordering of the LSMs.  I wonder
how much that would matter.

I'll implement your other changes, and consider switching to a
stackerfs (versus changing the content presentation under sysfs).

thanks,
-serge
