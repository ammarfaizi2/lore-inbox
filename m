Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964968AbVIVTdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964968AbVIVTdE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:33:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbVIVTdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:33:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19369 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964968AbVIVTdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:33:02 -0400
Date: Thu, 22 Sep 2005 12:31:50 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Lever, Charles" <Charles.Lever@netapp.com>
Cc: SteveD@redhat.com, NFS@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [NFS] Re: [PATCH] repair nfsd/sunrpc in 2.6.14-rc2-mm1 (and
 other -mm versions)
Message-Id: <20050922123150.7a147d1e.akpm@osdl.org>
In-Reply-To: <044B81DE141D7443BCE91E8F44B3C1E288E488@exsvl02.hq.netapp.com>
References: <044B81DE141D7443BCE91E8F44B3C1E288E488@exsvl02.hq.netapp.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Lever, Charles" <Charles.Lever@netapp.com> wrote:
>
> > -----Original Message-----
>  > From: Steve Dickson [mailto:SteveD@redhat.com] 
>  > Sent: Thursday, September 22, 2005 10:02 AM
>  > To: linux-kernel
>  > Cc: NFS@lists.sourceforge.net
>  > Subject: [NFS] Re: [PATCH] repair nfsd/sunrpc in 
>  > 2.6.14-rc2-mm1 (and other -mm versions)
>  > 
>  > Max Kellermann wrote:
>  > > Your -mm patches make the sunrpc client connect to the 
>  > portmapper with
>  > > a non-privileged source port.  This is due to a change in
>  > > net/sunrpc/pmap_clnt.c, which manually resets the xprt->resvport
>  > > field.  My tiny patch removes this line.  I have no idea 
>  > why the line
>  > > was added in the first place, does somebody know better?
>  > Yes this is a bug, since most Linux portmapper will not
>  > allow ports to be set or unset using non-privilege ports.
>  > But non-privilege ports can be used to get ports information.
>  > So I would suggest the following patch that stops the
>  > use of privileges ports on only get port requests.
> 
>  this was my patch (idea was steve's).  i've already sent a fix to
>  andrew.  andrew please let me know if you haven't received it.

Ah, good.  Please resend?

