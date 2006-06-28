Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423358AbWF1OaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423358AbWF1OaT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 10:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423362AbWF1OaS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 10:30:18 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:16398 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S1423358AbWF1OaQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 10:30:16 -0400
Message-ID: <20060628183015.B31885@castle.nmd.msu.ru>
Date: Wed, 28 Jun 2006 18:30:15 +0400
From: Andrey Savochkin <saw@swsoft.com>
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, serue@us.ibm.com,
       haveblue@us.ibm.com, clg@fr.ibm.com, Andrew Morton <akpm@osdl.org>,
       dev@sw.ru, herbert@13thfloor.at, devel@openvz.org, sam@vilain.net,
       ebiederm@xmission.com, viro@ftp.linux.org.uk, alexey@sw.ru
Subject: Re: [patch 3/4] Network namespaces: IPv4 FIB/routing in namespaces
References: <20060626134945.A28942@castle.nmd.msu.ru> <20060626135250.B28942@castle.nmd.msu.ru> <20060626135427.C28942@castle.nmd.msu.ru> <449FF5AE.2040201@fr.ibm.com> <44A28964.2090006@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <44A28964.2090006@fr.ibm.com>; from "Daniel Lezcano" on Wed, Jun 28, 2006 at 03:51:32PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

On Wed, Jun 28, 2006 at 03:51:32PM +0200, Daniel Lezcano wrote:
> Daniel Lezcano wrote:
> > Andrey Savochkin wrote:
> > 
> >> Structures related to IPv4 rounting (FIB and routing cache)
> >> are made per-namespace.
> 
> Hi Andrey,
> 
> if the ressources are private to the namespace, how do you will handle 
> NFS mounted before creating the network namespace ? Do you take care of 
> that or simply assume you can't access NFS anymore ?

This is a question that brings up another level of interaction between
networking and the rest of kernel code.
Solution that I use now makes the NFS communication part always run in
the root namespace.  This is discussable, of course, but it's a far more
complicated matter than just device lists or routing :)

Best regards

Andrey
