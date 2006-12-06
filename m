Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937097AbWLFSn7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937097AbWLFSn7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 13:43:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937096AbWLFSn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 13:43:59 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60943 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937052AbWLFSn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 13:43:58 -0500
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0612061017220.3542@woody.osdl.org> 
References: <Pine.LNX.4.64.0612061017220.3542@woody.osdl.org>  <Pine.LNX.4.64.0612060822260.3542@woody.osdl.org> <1165125055.5320.14.camel@gullible> <20061203011625.60268114.akpm@osdl.org> <Pine.LNX.4.64N.0612051642001.7108@blysk.ds.pg.gda.pl> <20061205123958.497a7bd6.akpm@osdl.org> <6FD5FD7A-4CC2-481A-BC87-B869F045B347@freescale.com> <20061205132643.d16db23b.akpm@osdl.org> <adaac22c9cu.fsf@cisco.com> <20061205135753.9c3844f8.akpm@osdl.org> <Pine.LNX.4.64N.0612061506460.29000@blysk.ds.pg.gda.pl> <20061206075729.b2b6aa52.akpm@osdl.org> <21690.1165426993@redhat.com> <Pine.LNX.4.64.0612060951150.3542@woody.osdl.org> <Pine.LNX.4.64.0612060955380.3542@woody.osdl.org> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
       "Maciej W. Rozycki" <macro@linux-mips.org>,
       Roland Dreier <rdreier@cisco.com>,
       Andy Fleming <afleming@freescale.com>,
       Ben Collins <ben.collins@ubuntu.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jeff@garzik.org>, linux-arch@vger.kernel.org
Subject: Re: [PATCH] Export current_is_keventd() for libphy 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Wed, 06 Dec 2006 18:43:22 +0000
Message-ID: <16935.1165430602@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

>  (a) "volatile" on kernel data is basically always a bug, and you should 
>      use locking.

But what about when you're building a lock?  Actually, I suspect correct usage
of asm constraints and memory barriers trumps volatile anyway even there.

David
