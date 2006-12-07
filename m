Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032276AbWLGP2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032276AbWLGP2M (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 10:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937985AbWLGP2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 10:28:12 -0500
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:4477 "EHLO
	pollux.ds.pg.gda.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1032276AbWLGP2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 10:28:10 -0500
Date: Thu, 7 Dec 2006 15:28:05 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: [PATCH] Export current_is_keventd() for libphy
In-Reply-To: <Pine.LNX.4.64.0612061719420.3542@woody.osdl.org>
Message-ID: <Pine.LNX.4.64N.0612071516390.22220@blysk.ds.pg.gda.pl>
References: <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org>
 <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl>
 <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com>
 <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com>
 <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl>
 <20061206075729.b2b6aa52.akpm@osdl.org> <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org>
 <Pine.LNX.4.64.0612061719420.3542@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006, Linus Torvalds wrote:

> I didn't get any answers on this. I'd like to get this issue resolved, but 
> since I don't even use libphy on my main machine, I need somebody else to 
> test it for me.

 I tested it in the evening with the system I implemented it for 
originally.  It seems to work -- it does not oops as would the original 
code without the call to flush_scheduled_work() nor does it deadlock as 
would code with the call (and no special precautions).

 Thanks a lot (and congrats for still being capable of doing something 
else from merging).

  Maciej
