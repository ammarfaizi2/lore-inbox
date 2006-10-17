Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751284AbWJQQ0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbWJQQ0H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 12:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbWJQQ0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 12:26:07 -0400
Received: from pfx2.jmh.fr ([194.153.89.55]:35803 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1751284AbWJQQ0F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 12:26:05 -0400
From: Eric Dumazet <dada1@cosmosbay.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [take19 1/4] kevent: Core files.
Date: Tue, 17 Oct 2006 18:26:04 +0200
User-Agent: KMail/1.9.5
Cc: Johann Borck <johann.borck@densedata.com>,
       Ulrich Drepper <drepper@redhat.com>, Ulrich Drepper <drepper@gmail.com>,
       lkml <linux-kernel@vger.kernel.org>, David Miller <davem@davemloft.net>,
       Andrew Morton <akpm@osdl.org>, netdev <netdev@vger.kernel.org>,
       Zach Brown <zach.brown@oracle.com>,
       Christoph Hellwig <hch@infradead.org>,
       Chase Venters <chase.venters@clientec.com>
References: <11587449471424@2ka.mipt.ru> <200610171732.28640.dada1@cosmosbay.com> <20061017160155.GA18522@2ka.mipt.ru>
In-Reply-To: <20061017160155.GA18522@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610171826.05028.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 17 October 2006 18:01, Evgeniy Polyakov wrote:

> Ok, there is one apologist for mmap buffer implementation, who forced me
> to create first implementation, which was dropped due to absense of
> remote mental reading abilities.
> Ulrich, does above approach sound good for you?
> I actually do not want to reimplement something, that will be
> pointed to with words 'no matter what you say, it is broken and I do not
> want it' again :).

In my humble opinion, you should first write a 'real application', to show how 
the mmap buffer and kevent syscalls would be used (fast path and 
slow/recovery paths). I am sure it would be easier for everybody to agree on 
the API *before* you start coding a *lot* of hard (kernel) stuff : It would 
certainly save your mental CPU cycles (and ours too :) )

This 'real application' could be  the event loop of a simple HTTP server, or a 
basic 'echo all' server. Adding the bits about timers events and signals 
should be done too.

Eric
