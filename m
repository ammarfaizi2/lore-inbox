Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261458AbVC2Vcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261458AbVC2Vcu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261452AbVC2Vac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:30:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13201 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261511AbVC2V3x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:29:53 -0500
Date: Tue, 29 Mar 2005 16:29:49 -0500
From: Neil Horman <nhorman@redhat.com>
To: jamal <hadi@cyberus.ca>
Cc: Neil Horman <nhorman@redhat.com>, linux-kernel@vger.kernel.org,
       "David S. Miller" <davem@davemloft.net>, netdev <netdev@oss.sgi.com>
Subject: Re: [Patch] net: fix build break when CONFIG_NET_CLS_ACT is not set
Message-ID: <20050329212949.GR22447@hmsendeavour.rdu.redhat.com>
References: <20050329202506.GI22447@hmsendeavour.rdu.redhat.com> <1112130720.1076.112.camel@jzny.localdomain> <20050329211741.GL22447@hmsendeavour.rdu.redhat.com> <1112131560.1079.115.camel@jzny.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112131560.1079.115.camel@jzny.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 04:26:00PM -0500, jamal wrote:
> On Tue, 2005-03-29 at 16:17, Neil Horman wrote:
> 
> > No worries.  What exactly is the point of contention on netdev? (I'm not
> > currently following that list).  My patch seems to follow the common practice
> > for CONFIG_NET_CLS_ACT, in that all references to the action member of the
> > appropriate struct are themselves ifdef-ed.
> 
> We are trying to kill appearance of any #ifdef CONFIG_NET_CLS_ACT in the
> classifiers. The patch you sent is correct except it will introduce
> an ifdef that we are trying to kill. The current workaround is to turn
> on CONFIG_NET_CLS_ACT in the kernel build.
> 
> cheers,
> jamal
> 
Gotcha.  That seems like a pretty good idea. :)  Thanks!
Neil

> 
> 

-- 
/***************************************************
 *Neil Horman
 *Software Engineer
 *Red Hat, Inc.
 *nhorman@redhat.com
 *gpg keyid: 1024D / 0x92A74FA1
 *http://pgp.mit.edu
 ***************************************************/
