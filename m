Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285444AbRLGJxM>; Fri, 7 Dec 2001 04:53:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285447AbRLGJww>; Fri, 7 Dec 2001 04:52:52 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:725 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S285444AbRLGJwp>;
	Fri, 7 Dec 2001 04:52:45 -0500
Importance: Normal
Subject: Re: [Lse-tech] [RFC] [PATCH] Scalable Statistics Counters
To: dipankar@beaverton.ibm.com
Cc: kiran@linux.ibm.com, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFEDC68CF2.34B05314-ON85256B1B.00355B4C@raleigh.ibm.com>
From: "Niels Christiansen" <nchr@us.ibm.com>
Date: Fri, 7 Dec 2001 04:52:40 -0500
X-MIMETrack: Serialize by Router on D04NM104/04/M/IBM(Release 5.0.8 |June 18, 2001) at
 12/07/2001 04:52:41 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Dikanpar,

| > Anyway, since we just had a long thread going on NUMA topology, maybe
| > it would be proper to investigate if there is a better way, such as
| > using the topology to decide where to put counters?  I think so, seeing
| > as it is that most Intel based 8-ways and above will have at least some
| > NUMA in them.
|
| It should be easy to place the counters in appropriately close
| memory if linux gets good NUMA APIs built on top of the topology
| services. If we extend kmem_cache_alloc() to allocate memory
| in a particular NUMA node, we could simply do this for placing the
| counters -
| ...
| This would put the block of counters corresponding to a CPU in
| memory local to the NUMA node. If there are more sophisticated
| APIs available for suitable memory selection, those too can be made
| use of here.
|
| Is this the kind of thing you are looking at ?

I'm no NUMA person so I can't verify your code snippet but if it does
what you say, yes, that is exactly what I meant:  We may have to deal
with both cache coherence and placement of counters in local memory.

Niels

