Return-Path: <linux-kernel-owner+w=401wt.eu-S932341AbXAISgh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbXAISgh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:36:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbXAISgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:36:37 -0500
Received: from mms3.broadcom.com ([216.31.210.19]:1843 "EHLO MMS3.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932341AbXAISgg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:36:36 -0500
X-Greylist: delayed 412 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jan 2007 13:36:36 EST
X-Server-Uuid: 9206F490-5C8F-4575-BE70-2AAA8A3D4853
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: [openib-general] [PATCH 1/10] cxgb3 - main header files
Date: Tue, 9 Jan 2007 10:29:12 -0800
Message-ID: <54AD0F12E08D1541B826BE97C98F99F1EE6B67@NT-SJCA-0751.brcm.ad.broadcom.com>
In-Reply-To: <20070109135725.GF16107@mellanox.co.il>
Thread-Topic: [openib-general] [PATCH 1/10] cxgb3 - main header files
Thread-Index: Accz9o/MJZCtcLMBQNmxA1maERaxmQAJK+pw
From: "Caitlin Bestler" <caitlinb@broadcom.com>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>,
       "Steve Wise" <swise@opengridcomputing.com>
cc: netdev@vger.kernel.org, "Roland Dreier" <rdreier@cisco.com>,
       "Divy Le Ray" <divy@chelsio.com>, linux-kernel@vger.kernel.org,
       "openib-general" <openib-general@openib.org>
X-WSS-ID: 69BD00852CC18761823-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: openib-general-bounces@openib.org 
> [mailto:openib-general-bounces@openib.org] On Behalf Of 
> Michael S. Tsirkin
> Sent: Tuesday, January 09, 2007 5:57 AM
> To: Steve Wise
> Cc: netdev@vger.kernel.org; Roland Dreier; Divy Le Ray; 
> linux-kernel@vger.kernel.org; openib-general
> Subject: Re: [openib-general] [PATCH 1/10] cxgb3 - main header files
> 
> > We also need to decide on the ib_req_notify_cq() issue.  
> 
> Let's clarify - do you oppose doing copy_from_user from a 
> fixed address passed in during setup?
> 
> If OK with you, this seems the best way as it is the least 
> controversial and least disruptive one.
> 
To clarfiy my understanding of this issue:

A device MAY implement ib_req_notify_cq by updating
a location directly from user mode. Any of the techniques
that apply to other user allocated objects, such as 
the Send Queue, can be applied here.

Even those the proposed changes would be about as
low impact and benign as possible, the fact that there
are valid solutions without an API changes leans heavily
towards using those solutions.

