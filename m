Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263448AbUECB4O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263448AbUECB4O (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 21:56:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbUECB4O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 21:56:14 -0400
Received: from pop.potsdam.edu ([137.143.110.102]:10955 "HELO mail.potsdam.edu")
	by vger.kernel.org with SMTP id S263448AbUECB4L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 21:56:11 -0400
Subject: Implementing an "on demand" routing protocol?
From: Peter Hernberg <petehern@yahoo.com>
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Content-Type: text/plain
Message-Id: <1083549369.613.23.camel@mine>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 02 May 2004 21:56:09 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm implementing the AODV routing protocol (RFC 3561) on Linux. One of
the protocol's salient features is being "on demand": rather than
receiving (and transmitting) regular updates on the topology of the
network, it waits until it needs a route to a given host (or network).
With AODV routing, in the following simple network

Host A <----> Host B <----> Host C,

it may be that A is unaware of its route to C. If A has a packet
destined for C, it buffers that packet and broadcasts a request for a
route to C.

Is there an interface whereby the kernel can be told "when you have a
packet, but lack a route to its destination, pass a message to this
daemon requesting a route and buffer that packet until the daemon is
done searching for route"? Any info would be appreciated.
-- 
Peter Hernberg

