Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030207AbVIVTxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030207AbVIVTxi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 15:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030285AbVIVTxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 15:53:38 -0400
Received: from mx2.netapp.com ([216.240.18.37]:22285 "EHLO mx2.netapp.com")
	by vger.kernel.org with ESMTP id S1030207AbVIVTxY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 15:53:24 -0400
X-IronPort-AV: i="3.97,138,1125903600"; 
   d="scan'208"; a="325344529:sNHT18379596"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [NFS] Re: [PATCH] repair nfsd/sunrpc in 2.6.14-rc2-mm1 (and other -mm versions)
Date: Thu, 22 Sep 2005 12:53:22 -0700
Message-ID: <044B81DE141D7443BCE91E8F44B3C1E288E48E@exsvl02.hq.netapp.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [NFS] Re: [PATCH] repair nfsd/sunrpc in 2.6.14-rc2-mm1 (and other -mm versions)
Thread-Index: AcW/rmP4SkG5o6+2Soej0FUQGA7RhgAALlpQ
From: "Lever, Charles" <Charles.Lever@netapp.com>
To: "Peter Staubach" <staubach@redhat.com>, "Andrew Morton" <akpm@osdl.org>
Cc: <SteveD@redhat.com>, <NFS@lists.sourceforge.net>,
       <linux-kernel@vger.kernel.org>,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>
X-OriginalArrivalTime: 22 Sep 2005 19:53:23.0876 (UTC) FILETIME=[4A6CE640:01C5BFAF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, Chuck's patch and Steve's aren't quite the same.  
> Both patches
> fix the problem that the portmap daemon requires a request to 
> set something
> to come from a reserved port.  In addition to this, Steve's 
> patch reduces
> the number of reserved ports that the kernel requires.  This 
> is the problem
> that resulted in pmap_create() being incorrectly modified in 
> the first 
> place.
> Steve's patch correctly puts the support in rpc_getport() 
> where it belongs.

mine does too.  pmap_create() is used for both GET and SET, and i added
a parm to allow pmap_create()'s caller to request a reserved port when
needed.
