Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbVIVOLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbVIVOLI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 10:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbVIVOLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 10:11:08 -0400
Received: from mx1.netapp.com ([216.240.18.38]:6500 "EHLO mx1.netapp.com")
	by vger.kernel.org with ESMTP id S1030364AbVIVOLH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 10:11:07 -0400
X-IronPort-AV: i="3.97,138,1125903600"; 
   d="scan'208"; a="258453957:sNHT18843224"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [NFS] Re: [PATCH] repair nfsd/sunrpc in 2.6.14-rc2-mm1 (and other -mm versions)
Date: Thu, 22 Sep 2005 07:11:05 -0700
Message-ID: <044B81DE141D7443BCE91E8F44B3C1E288E488@exsvl02.hq.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [NFS] Re: [PATCH] repair nfsd/sunrpc in 2.6.14-rc2-mm1 (and other -mm versions)
Thread-Index: AcW/foZAVqJ5rqW2T/GNegHMm9yFqQAALVJw
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: "Steve Dickson" <SteveD@redhat.com>, <akpm@osdl.org>
Cc: <NFS@lists.sourceforge.net>, "linux-kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 22 Sep 2005 14:11:06.0517 (UTC) FILETIME=[79349C50:01C5BF7F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Steve Dickson [mailto:SteveD@redhat.com] 
> Sent: Thursday, September 22, 2005 10:02 AM
> To: linux-kernel
> Cc: NFS@lists.sourceforge.net
> Subject: [NFS] Re: [PATCH] repair nfsd/sunrpc in 
> 2.6.14-rc2-mm1 (and other -mm versions)
> 
> Max Kellermann wrote:
> > Your -mm patches make the sunrpc client connect to the 
> portmapper with
> > a non-privileged source port.  This is due to a change in
> > net/sunrpc/pmap_clnt.c, which manually resets the xprt->resvport
> > field.  My tiny patch removes this line.  I have no idea 
> why the line
> > was added in the first place, does somebody know better?
> Yes this is a bug, since most Linux portmapper will not
> allow ports to be set or unset using non-privilege ports.
> But non-privilege ports can be used to get ports information.
> So I would suggest the following patch that stops the
> use of privileges ports on only get port requests.

this was my patch (idea was steve's).  i've already sent a fix to
andrew.  andrew please let me know if you haven't received it.
