Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261855AbVANCmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261855AbVANCmn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 21:42:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbVANCmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 21:42:42 -0500
Received: from out009pub.verizon.net ([206.46.170.131]:27578 "EHLO
	out009.verizon.net") by vger.kernel.org with ESMTP id S261855AbVANCl0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 21:41:26 -0500
Message-Id: <200501140240.j0E2esKG026962@localhost.localdomain>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: utz lehmann <lkml@s2y4n2c.de>, Lee Revell <rlrevell@joe-job.com>,
       Arjan van de Ven <arjanv@redhat.com>, "Jack O'Quin" <joq@io.com>,
       Chris Wright <chrisw@osdl.org>, Matt Mackall <mpm@selenic.com>,
       Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       mingo@elte.hu, alan@lxorguk.ukuu.org.uk,
       LKML <linux-kernel@vger.kernel.org>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [PATCH] [request for inclusion] Realtime LSM 
In-reply-to: Your message of "Fri, 14 Jan 2005 13:24:11 +1100."
             <1105669451.5402.38.camel@npiggin-nld.site> 
Date: Thu, 13 Jan 2005 21:40:54 -0500
From: Paul Davis <paul@linuxaudiosystems.com>
X-Authentication-Info: Submitted using SMTP AUTH at out009.verizon.net from [141.152.253.251] at Thu, 13 Jan 2005 20:41:24 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>SCHED_FIFO and SCHED_RR are definitely privileged operations and you

this is the crux of what this whole debate is about. for all of you
people who think about linux on multi-user systems with network
connectivity, running servers and so forth, this is clearly a given.

but there is large and growing body of machines that run linux where
the sole human user of the machine has a strong and overwhelming
desire to have tasks run with the characteristics offered by
SCHED_FIFO and/or SCHED_RR. are they still "privileged" operations on
this class of linux system? what about linux installed on an embedded
system, with a small LCD screen and the sole purpose of running audio
apps live? are they still privileged then?

i think there is room for debate, but its clear that in general,
SCHED_FIFO/SCHED_RR's "definite" status as privileged operations is
not clear. we are trying to find ways to provide access to it in ways
that don't conflict with the other categories of linux systems where
it clearly needs to be off-limits to unprivileged users.

--p


