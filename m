Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262516AbVGFW3r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262516AbVGFW3r (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 18:29:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbVGFW2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 18:28:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:30361 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262563AbVGFWWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 18:22:50 -0400
Date: Wed, 6 Jul 2005 15:22:37 -0700
From: Greg KH <greg@kroah.com>
To: serue@us.ibm.com
Cc: James Morris <jmorris@redhat.com>, Tony Jones <tonyj@suse.de>,
       serge@hallyn.com, lkml <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@osdl.org>, Stephen Smalley <sds@epoch.ncsc.mil>,
       Andrew Morton <akpm@osdl.org>, Michael Halcrow <mhalcrow@us.ibm.com>,
       David Safford <safford@watson.ibm.com>,
       Reiner Sailer <sailer@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [PATCH] securityfs
Message-ID: <20050706222237.GB6696@kroah.com>
References: <20050703182505.GA29491@immunix.com> <Xine.LNX.4.44.0507031450540.30297-100000@thoron.boston.redhat.com> <20050703204423.GA17418@kroah.com> <20050706220835.GA32005@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050706220835.GA32005@serge.austin.ibm.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2005 at 05:08:35PM -0500, serue@us.ibm.com wrote:
> Quoting Greg KH (greg@kroah.com):
> > think it could be made even smaller if you use the default read and
> > write file type functions in libfs (look at the debugfs wrappers of them
> > for u8, u16, etc, for examples of how to use them.)
> 
> The attached patch cleans up the securelevel code for the seclvl file.
> Is this a reasonable way to go about this?

No.

> Or is there a better way to do this?

Look at how debugfs uses the libfs code.  We should not need to add
these handlers to securityfs.

thanks,

greg k-h
