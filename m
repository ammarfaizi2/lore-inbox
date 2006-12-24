Return-Path: <linux-kernel-owner+w=401wt.eu-S1751157AbWLXMa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751157AbWLXMa2 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 24 Dec 2006 07:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWLXMa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Dec 2006 07:30:28 -0500
Received: from smtp.osdl.org ([65.172.181.25]:60543 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751157AbWLXMa1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Dec 2006 07:30:27 -0500
Date: Sun, 24 Dec 2006 04:30:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: andrei.popa@i-neo.ro
Cc: Linus Torvalds <torvalds@osdl.org>,
       Gordon Farquharson <gordonfarquharson@gmail.com>,
       Martin Michlmayr <tbm@cyrius.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>,
       Hugh Dickins <hugh@veritas.com>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Arjan van de Ven <arjan@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: fix page_mkclean_one (was: 2.6.19 file content
 corruption on ext3)
Message-Id: <20061224043008.cabfcbb0.akpm@osdl.org>
In-Reply-To: <1166963161.7042.1.camel@localhost>
References: <97a0a9ac0612210117v6f8e7aefvcfb76de1db9120bb@mail.gmail.com>
	<97a0a9ac0612212020i6f03c3cem3094004511966e@mail.gmail.com>
	<Pine.LNX.4.64.0612212033120.3671@woody.osdl.org>
	<20061222100004.GC10273@deprecation.cyrius.com>
	<20061222021714.6a83fcac.akpm@osdl.org>
	<1166790275.6983.4.camel@localhost>
	<20061222123249.GG13727@deprecation.cyrius.com>
	<20061222125920.GA16763@deprecation.cyrius.com>
	<1166793952.32117.29.camel@twins>
	<20061222192027.GJ4229@deprecation.cyrius.com>
	<97a0a9ac0612240010x33f4c51cj32d89cb5b08d4332@mail.gmail.com>
	<Pine.LNX.4.64.0612240029390.3671@woody.osdl.org>
	<20061224005752.937493c8.akpm@osdl.org>
	<1166962478.7442.0.camel@localhost>
	<1166963161.7042.1.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Dec 2006 14:26:01 +0200
Andrei Popa <andrei.popa@i-neo.ro> wrote:

> I also tested with ext3 ordered, nobh  and I have file corruption...

ordered+nobh isn't a possible combination.  The filesystem probably ignored
nobh.  nobh mode only makes sense with data=writeback.
