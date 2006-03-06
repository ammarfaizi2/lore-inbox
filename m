Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751964AbWCFUdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbWCFUdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 15:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbWCFUdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 15:33:05 -0500
Received: from mms2.broadcom.com ([216.31.210.18]:57356 "EHLO
	mms2.broadcom.com") by vger.kernel.org with ESMTP id S1751467AbWCFUdD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 15:33:03 -0500
X-Server-Uuid: D9EB6F12-1469-4C1C-87A2-5E4C0D6F9D06
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Subject: RE: RFC: move SDP from AF_INET_SDP to IPPROTO_SDP
Date: Mon, 6 Mar 2006 12:32:50 -0800
Message-ID: <54AD0F12E08D1541B826BE97C98F99F12FBF39@NT-SJCA-0751.brcm.ad.broadcom.com>
Thread-Topic: RFC: move SDP from AF_INET_SDP to IPPROTO_SDP
Thread-Index: AcZBXIBB/aEgUuviRvyDoQHB5qtg4QAAB95A
From: "Caitlin Bestler" <caitlinb@broadcom.com>
To: "David Stevens" <dlstevens@us.ibm.com>
cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "Michael S. Tsirkin" <mst@mellanox.co.il>, netdev@vger.kernel.org
X-TMWD-Spam-Summary: SEV=1.1; DFV=A2006030606; IFV=2.0.6,4.0-7;
 RPD=4.00.0004;
 RPDID=303030312E30413039303230362E34343043394246392E303038342D412D;
 ENG=IBF; TS=20060306203325; CAT=NONE; CON=NONE;
X-MMS-Spam-Filter-ID: A2006030606_4.00.0004_2.0.6,4.0-7
X-WSS-ID: 6812431A4KO1434572-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: David Stevens [mailto:dlstevens@us.ibm.com] 
> Sent: Monday, March 06, 2006 12:32 PM
> To: Caitlin Bestler
> Cc: Linux Kernel Mailing List; Michael S. Tsirkin; 
> netdev@vger.kernel.org
> Subject: RE: RFC: move SDP from AF_INET_SDP to IPPROTO_SDP
> 
> IPPROTO_* should match the protocol field on the wire, which 
> I gather isn't different. And I'm assuming there is no 
> standard API defined already...
> 

SDP uses the existing standard sockets API.
That was the intent in its design, and it is
the sole justification for its use. If you are
not using the existing sockets API then your
application would be *far* better off coding
directly to RDMA.

The wire protocol *is* different, it uses RDMA.
There is some justification for the application
knowing this, albeit slight ones. For example 
you need to know if the peer supports SDP and
it might effect how intermediate firewalls
need to be configured.

