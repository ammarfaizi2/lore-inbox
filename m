Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVEUGQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVEUGQL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 02:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261668AbVEUGQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 02:16:11 -0400
Received: from mail.kroah.org ([69.55.234.183]:16519 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261673AbVEUGQC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 02:16:02 -0400
Date: Fri, 20 May 2005 22:57:06 -0700
From: Greg KH <greg@kroah.com>
To: Reiner Sailer <sailer@us.ibm.com>
Cc: James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
       Chris Wright <chrisw@osdl.org>, emilyr@us.ibm.com, yoder1@us.ibm.com,
       kylene@us.ibm.com, linux-kernel@vger.kernel.org, toml@us.ibm.com
Subject: Re: [PATCH 1 of 4] ima: related TPM device driver interal kernel interface
Message-ID: <20050521055705.GA24597@kroah.com>
References: <Pine.WNT.4.63.0505201634370.3360@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.WNT.4.63.0505201634370.3360@laptop>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2005 at 04:41:23PM -0400, Reiner Sailer wrote:
> James Morris <jmorris@redhat.com> wrote on 05/20/2005 04:32:58 PM:
> > On Fri, 20 May 2005, Reiner Sailer wrote:
> > 
> > > > Why are you using LSM for this?
> > > > 
> > > > LSM should be used for comprehensive access control frameworks which 
> > > > significantly enhance or even replace existing Unix DAC security.
> > > 
> > > I see LSM is framework for security. IMA is an architecture that
> > > enforces access control in a different way than SELinux. IMA guarantees 
> > > that executable content is measured and accounted for before
> > > it is loaded and can access (and possibly corrupt) system resources.
> > 
> > LSM is an access control framework.  Your (few) LSM hooks always return
> > zero, and don't enforce access control at all.  You even have a separate
> > measurement hook for modules.
> > 
> > I suggest implementing all of your code via distinct measurement hooks, so 
> > measurement becomes a distinct and well defined security entity within the 
> > kernel.
> 
> This is certainly possible. This means that there will be 5 more hooks
> (such as the one in kernel/module.c, see PATCH 4 of 4).
> 
> If the kernel maintainers are in favor of this approach, then there is not
> much that stands against this.

Yes, and it will force you to justify those hooks :)

Good luck,

greg k-h
