Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVETUll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVETUll (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 16:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVETUll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 16:41:41 -0400
Received: from igw2.watson.ibm.com ([129.34.20.6]:63916 "EHLO
	igw2.watson.ibm.com") by vger.kernel.org with ESMTP id S261577AbVETUl0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 16:41:26 -0400
Date: Fri, 20 May 2005 16:41:23 -0400 (Eastern Daylight Time)
From: Reiner Sailer <sailer@us.ibm.com>
To: James Morris <jmorris@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, Chris Wright <chrisw@osdl.org>,
       emilyr@us.ibm.com, yoder1@us.ibm.com, kylene@us.ibm.com,
       linux-kernel@vger.kernel.org, toml@us.ibm.com
Subject: Re: [PATCH 1 of 4] ima: related TPM device driver interal kernel
 interface
Message-ID: <Pine.WNT.4.63.0505201634370.3360@laptop>
X-Warning: UNAuthenticated Sender
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Morris <jmorris@redhat.com> wrote on 05/20/2005 04:32:58 PM:

> On Fri, 20 May 2005, Reiner Sailer wrote:
> 
> > > Why are you using LSM for this?
> > > 
> > > LSM should be used for comprehensive access control frameworks which 
> > > significantly enhance or even replace existing Unix DAC security.
> > 
> > I see LSM is framework for security. IMA is an architecture that
> > enforces access control in a different way than SELinux. IMA guarantees 
> > that executable content is measured and accounted for before
> > it is loaded and can access (and possibly corrupt) system resources.
> 
> LSM is an access control framework.  Your (few) LSM hooks always return
> zero, and don't enforce access control at all.  You even have a separate
> measurement hook for modules.
> 
> I suggest implementing all of your code via distinct measurement hooks, so 
> measurement becomes a distinct and well defined security entity within the 
> kernel.

This is certainly possible. This means that there will be 5 more hooks
(such as the one in kernel/module.c, see PATCH 4 of 4).

If the kernel maintainers are in favor of this approach, then there is not
much that stands against this.

> LSM should not be used just because it has a few hooks in the right place
> for your code.
>
> 
> - James
> -- 
> James Morris
> <jmorris@redhat.com>
> 
> 
> 
> 

Thanks
Reiner

