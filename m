Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932406AbVJaTmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVJaTmT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 14:42:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932416AbVJaTmS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 14:42:18 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:451 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932406AbVJaTmS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 14:42:18 -0500
In-Reply-To: <4365A995.3050404@21cn.com>
To: Yan Zheng <yanzheng@21cn.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [PATCH][MCAST]IPv6: Check packet size when process Multicast Address
 and Source Specific Query
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF1A55BA31.24DA7F68-ON882570AB.006BBA0E-882570AB.006C3CFC@us.ibm.com>
From: David Stevens <dlstevens@us.ibm.com>
Date: Mon, 31 Oct 2005 11:42:28 -0800
X-MIMETrack: Serialize by Router on D03NM121/03/M/IBM(Release 6.53HF654 | July 22, 2005) at
 10/31/2005 12:42:30,
	Serialize complete at 10/31/2005 12:42:30
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this should be modelled after the equivalent code in IGMPv3.
See igmp_heard_query() in net/ipv4/igmp.c. For ease of maintenance,
the code should be structured exactly the same way, except for
necessary differences, of course.

I haven't seen enough context yet, but  I think you need to check
for the query header itself, too (as done in IGMPv3).

I'm reviewing your other patches as well.

                                        +-DLS

