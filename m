Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261367AbSIZPIy>; Thu, 26 Sep 2002 11:08:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261369AbSIZPIy>; Thu, 26 Sep 2002 11:08:54 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:49675 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S261367AbSIZPIx>; Thu, 26 Sep 2002 11:08:53 -0400
Date: Fri, 27 Sep 2002 01:13:37 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Roberto Nibali <ratz@drugphish.ch>
cc: "David S. Miller" <davem@redhat.com>, Andi Kleen <ak@suse.de>,
       <niv@us.ibm.com>, <linux-kernel@vger.kernel.org>,
       jamal <hadi@cyberus.ca>
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
In-Reply-To: <3D92D243.6060808@drugphish.ch>
Message-ID: <Mutt.LNX.4.44.0209270051180.12285-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Sep 2002, Roberto Nibali wrote:

> Yes, we're doing tests in this field now (as with evlog) but as it seems 
> from preliminary testing netlink transportation of binary data is not 
> 100% reliable either.

Non-blocking netlink delivery is reliable, although you can overrun the 
userspace socket buffer (this can be detected, however).  The fundamental 
issue remains: sending more data to userspace than can be handled.

A truly reliable transport would also involve an ack based protocol .  
Under certain circumstances (e.g. log every forwarded packet for audit
purposes), packets would need to be dropped if the logging mechanism
became overloaded.  This would in turn involve some kind of queuing
mechanism and introduce a new set of performance problems.  Reliable
logging is a challenging problem area in general, probably better suited
to dedicated hardware environments where the software can be tuned to
known system capabilities.


- James
-- 
James Morris
<jmorris@intercode.com.au>


