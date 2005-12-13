Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbVLMNPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbVLMNPf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 08:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbVLMNPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 08:15:35 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:63976 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932155AbVLMNPf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 08:15:35 -0500
Subject: Re: [PATCH 1/19] MUTEX: Introduce simple mutex implementation
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, hch@infradead.org, arjan@infradead.org,
       matthew@wil.cx, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <1134479118.11732.14.camel@localhost.localdomain>
References: <dhowells1134431145@warthog.cambridge.redhat.com>
	 <1134479118.11732.14.camel@localhost.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 13 Dec 2005 13:15:13 +0000
Message-Id: <1134479713.11732.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually a PS to this while I think about it. spin_locks and mutex type
locks could both do with a macro for

	call_locked(&lock, foo(a,b,c,d))

to cut down on all the error path forgot to release a lock type errors.

