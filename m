Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262409AbSJEQUF>; Sat, 5 Oct 2002 12:20:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262410AbSJEQUF>; Sat, 5 Oct 2002 12:20:05 -0400
Received: from foonix.foonet.net ([216.207.29.74]:38840 "EHLO
	foonix.foonet.net") by vger.kernel.org with ESMTP
	id <S262409AbSJEQUE>; Sat, 5 Oct 2002 12:20:04 -0400
From: "CIT/Paul" <xerox@foonet.net>
To: <linux-kernel@vger.kernel.org>
Subject: Disabling route-cache?
Date: Sat, 5 Oct 2002 12:25:47 -0400
Organization: CIT
Message-ID: <006601c26c8b$dd16d430$4a00000a@badass>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To: 'linux-kernel@vger.kernel.org'
Subject: Disabling route-cache?


We have some linux routers and wish to disable the route cache. Is there
a way to do that? 
The route cache is using so much of the CPU that it is making routing
ineffective.  We are routing high
PPS > 100,000 and with the route cache enabled it will not even do half
of that.   We tested by creating
a single ip -> ip flow at 100,000 pps and the machine routed it just
fine, however when we create a 100,000 ip -> 100,000 ip test
the machine drops 80% of the packets due to creating and tearing down
massive entries in the route cache.
I wish for it to work like Cisco's CEF with only an adjacency cache  and
not a route cache for every flow. 
I don't know why it doesn't work this way in the first place.  Only the
ip_conntrack should keep track of flows (on a side note
if we enable ip_conntrack the whole machine goes to pot, there's no way
it's going to do it with that module loaded).

Please if anyone has any ideas.  Thanks

