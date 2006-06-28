Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423355AbWF1OTS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423355AbWF1OTS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423356AbWF1OTR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:19:17 -0400
Received: from MAIL.13thfloor.at ([212.16.62.50]:61931 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1423354AbWF1OTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:19:13 -0400
Date: Wed, 28 Jun 2006 16:19:12 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
       clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
       devel@openvz.org, sam@vilain.net, ebiederm@xmission.com,
       viro@ftp.linux.org.uk
Subject: Re: [patch 3/4] Network namespaces: IPv4 FIB/routing in namespaces
Message-ID: <20060628141912.GC5572@MAIL.13thfloor.at>
Mail-Followup-To: Daniel Lezcano <dlezcano@fr.ibm.com>,
	Andrey Savochkin <saw@swsoft.com>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, serue@us.ibm.com, haveblue@us.ibm.com,
	clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>, dev@sw.ru,
	devel@openvz.org, sam@vilain.net, ebiederm@xmission.com,
	viro@ftp.linux.org.uk
References: <20060626134945.A28942@castle.nmd.msu.ru> <20060626135250.B28942@castle.nmd.msu.ru> <20060626135427.C28942@castle.nmd.msu.ru> <449FF5AE.2040201@fr.ibm.com> <44A28964.2090006@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44A28964.2090006@fr.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2006 at 03:51:32PM +0200, Daniel Lezcano wrote:
> Daniel Lezcano wrote:
> >Andrey Savochkin wrote:
> >
> >>Structures related to IPv4 rounting (FIB and routing cache)
> >>are made per-namespace.
> 
> Hi Andrey,
> 
> if the ressources are private to the namespace, how do you will 
> handle NFS mounted before creating the network namespace ? 
> Do you take care of that or simply assume you can't access NFS anymore ?

considering that many providers put their guests
on NFS (or similar) filers, and run them on nodes
(for distributing the CPU load), that is indeed an
interesting question ...

what will happen to AOE or iSCSI btw?

best,
Herbert

> Regards
> 
>  -Daniel
