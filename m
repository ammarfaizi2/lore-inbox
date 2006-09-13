Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWIMOcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWIMOcc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750888AbWIMOcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:32:32 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:23239 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750885AbWIMOcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:32:31 -0400
In-Reply-To: <1158156835.15449.40.camel@dantu.rdu.redhat.com>
To: Jeff Layton <jlayton@poochiereds.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       netdev-owner@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH] make ipv4 multicast packets only get delivered to sockets	that
 are joined to group
X-Mailer: Lotus Notes Release 7.0 HF144 February 01, 2006
Message-ID: <OF0C86B64A.DE64FE98-ON882571E8.004F57A7-882571E8.004FDDED@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Wed, 13 Sep 2006 07:32:22 -0700
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 7.0.1HF269 | June 22, 2006) at
 09/13/2006 08:32:24,
	Serialize complete at 09/13/2006 08:32:24
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

netdev-owner@vger.kernel.org wrote on 09/13/2006 07:13:55 AM:

> Only
> the socket that is bound to the group address to which the packet was
> sent should get it.

        This is not true on any OS I'm aware of, including the
original sockets multicast implementation on early BSD.

        Multicast group membership is per-interface, not per-socket.
Joining a group on any socket on the machine allows packets for that
group to be delivered on the interface where it was joined.

Delivery of packets to a socket is determined by the binding, and
INADDR_ANY means "any".

IPv6 behaves the same way.
                                                                +-DLS


