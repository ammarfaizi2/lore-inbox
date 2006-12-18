Return-Path: <linux-kernel-owner+w=401wt.eu-S1752177AbWLRDKP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbWLRDKP (ORCPT <rfc822;w@1wt.eu>);
	Sun, 17 Dec 2006 22:10:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752187AbWLRDKP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Dec 2006 22:10:15 -0500
Received: from smtp.osdl.org ([65.172.181.25]:52438 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177AbWLRDKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Dec 2006 22:10:14 -0500
Date: Sun, 17 Dec 2006 19:09:36 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Christoph Hellwig <hch@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH, RFC] reimplement flush_workqueue()
In-Reply-To: <20061217223416.GA6872@tv-sign.ru>
Message-ID: <Pine.LNX.4.64.0612171909110.3479@woody.osdl.org>
References: <20061217223416.GA6872@tv-sign.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 18 Dec 2006, Oleg Nesterov wrote:
>
> Remove ->remove_sequence, ->insert_sequence, and ->work_done from
> struct cpu_workqueue_struct. To implement flush_workqueue() we can
> queue a barrier work on each CPU and wait for its completition.

Looks fine to me. It's after -rc1 so I won't apply it, but it looks like a 
nice cleanup.

		Linus
