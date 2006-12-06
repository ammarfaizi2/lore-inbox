Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936933AbWLFRuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936933AbWLFRuk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936943AbWLFRuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:50:40 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:57734 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936957AbWLFRuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:50:39 -0500
Message-ID: <457702E2.3000703@garzik.org>
Date: Wed, 06 Dec 2006 12:50:26 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
References: <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>  <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org> <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl> <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com> <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com> <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl> <20061206075729.b2b6aa52.akpm@osdl.org> <21690.1165426993@redhat.com>
In-Reply-To: <21690.1165426993@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Honestly I wonder if some of these situations really want 
"kill_scheduled_work_unless_it_is_already_running_right_now_if_so_wait_for_it"

Since its during shutdown, usually the task just wants to know that the 
code in the workqueue won't be touching the hardware or data structures 
after <this> point.

	Jeff



