Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750750AbWIMQqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbWIMQqm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750765AbWIMQqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:46:42 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:53476 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750750AbWIMQqk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:46:40 -0400
In-Reply-To: <1158163943.15449.75.camel@dantu.rdu.redhat.com>
To: Jeff Layton <jlayton@poochiereds.net>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH] make ipv4 multicast packets only get delivered to	sockets	that
 are joined to group
X-Mailer: Lotus Notes Release 7.0 HF144 February 01, 2006
Message-ID: <OF92367C0E.A403488D-ON882571E8.00599D09-882571E8.005BC0EB@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Wed, 13 Sep 2006 09:42:11 -0700
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 7.0.1HF269 | June 22, 2006) at
 09/13/2006 10:46:39,
	Serialize complete at 09/13/2006 10:46:39
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Layton <jlayton@poochiereds.net> wrote on 09/13/2006 09:12:23 AM:

> Most of the RFC's I've looked at don't seem to have much to say about
> how multicasting works at the socket level. Is there an RFC or
> specification that spells this out, or is this one of those situations
> where things are somewhat open to interpretation?

        RFC's are standards for protocols and are concerned with
interoperability among multiple implementations. They, in general,
do not define API's (and those that do are "informational").
        There are after-the-fact standards for sockets, including
POSIX, but older features are effectively defined by industry
practice; in this case, Deering's BSD implementation from nearly
20 years ago.
        Sections 7.1 & 7.2 of RFC 988 [Deering, 1986] hint at this
interpretation (separation of membership from socket delivery),
esp. when it says "Incoming multicast IP datagrams are
delivered to upper-layer protocol modules using the
same 'Receive IP' operation as normal, unicast
datagrams."
        But Deering's own implementation, which
does not distinguish which socket joined the group,
is the source of the standard practice.

                                                        +-DLS

