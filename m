Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261519AbVC2VaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261519AbVC2VaC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 16:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261483AbVC2V3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 16:29:39 -0500
Received: from mx01.cybersurf.com ([209.197.145.104]:14526 "EHLO
	mx01.cybersurf.com") by vger.kernel.org with ESMTP id S261452AbVC2V0M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 16:26:12 -0500
Subject: Re: [Patch] net: fix build break when CONFIG_NET_CLS_ACT is not set
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Neil Horman <nhorman@redhat.com>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       netdev <netdev@oss.sgi.com>
In-Reply-To: <20050329211741.GL22447@hmsendeavour.rdu.redhat.com>
References: <20050329202506.GI22447@hmsendeavour.rdu.redhat.com>
	 <1112130720.1076.112.camel@jzny.localdomain>
	 <20050329211741.GL22447@hmsendeavour.rdu.redhat.com>
Content-Type: text/plain
Organization: jamalopolous
Message-Id: <1112131560.1079.115.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 29 Mar 2005 16:26:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-29 at 16:17, Neil Horman wrote:

> No worries.  What exactly is the point of contention on netdev? (I'm not
> currently following that list).  My patch seems to follow the common practice
> for CONFIG_NET_CLS_ACT, in that all references to the action member of the
> appropriate struct are themselves ifdef-ed.

We are trying to kill appearance of any #ifdef CONFIG_NET_CLS_ACT in the
classifiers. The patch you sent is correct except it will introduce
an ifdef that we are trying to kill. The current workaround is to turn
on CONFIG_NET_CLS_ACT in the kernel build.

cheers,
jamal



