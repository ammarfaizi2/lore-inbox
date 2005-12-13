Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932626AbVLMXU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbVLMXU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 18:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbVLMXU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 18:20:56 -0500
Received: from moraine.clusterfs.com ([66.96.26.190]:60327 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S932624AbVLMXUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 18:20:55 -0500
From: Nikita Danilov <nikita@clusterfs.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17311.22374.434801.753813@gargle.gargle.HOWL>
Date: Wed, 14 Dec 2005 02:21:10 +0300
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
Newsgroups: gmane.linux.kernel
In-Reply-To: <1134479713.11732.25.camel@localhost.localdomain>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	<1134479118.11732.14.camel@localhost.localdomain>
	<1134479713.11732.25.camel@localhost.localdomain>
X-Mailer: VM 7.17 under 21.5 (patch 17) "chayote" (+CVS-20040321) XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
 > Actually a PS to this while I think about it. spin_locks and mutex type
 > locks could both do with a macro for
 > 
 > 	call_locked(&lock, foo(a,b,c,d))

reiser4 code was publicly humiliated for such macros, but indeed they
are useful. The only problem is that one needs two macros: one for foo()
returning void and one for all other cases.

 > 
 > to cut down on all the error path forgot to release a lock type errors.
 > 

Nikita.
