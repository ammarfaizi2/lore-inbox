Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271710AbTGRF4k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 01:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271711AbTGRF4k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 01:56:40 -0400
Received: from trappist.elis.UGent.be ([157.193.204.1]:62652 "EHLO
	trappist.elis.UGent.be") by vger.kernel.org with ESMTP
	id S271710AbTGRF4j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 01:56:39 -0400
Date: Fri, 18 Jul 2003 08:10:55 +0200 (CEST)
From: Frank Cornelis <fcorneli@elis.ugent.be>
To: Christoph Hellwig <hch@infradead.org>
cc: Frank Cornelis <Frank.Cornelis@elis.UGent.be>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: __put_task_struct
In-Reply-To: <20030717170156.B9432@infradead.org>
Message-ID: <Pine.LNX.4.44.0307180807280.24349-100000@trappist.elis.UGent.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003, Christoph Hellwig wrote:

> On Wed, Jul 16, 2003 at 04:58:15PM +0200, Frank Cornelis wrote:

> > When using get/put_task_struct from inside a module, kbuild warns about
> > __put_task_struct being undefined. Can someone export this function?
> 
> Why would you use it in a module?

To make sure nobody destroys the task_struct while I'm manipulating it
(of course using task_lock/unlock). I'm just using the same 'lock 
strategy' as done in asm/i386/kernel/ptrace.c and I guess that code is 
correct.

Frank.

