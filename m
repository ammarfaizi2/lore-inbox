Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267283AbUHOX4Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267283AbUHOX4Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 19:56:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267274AbUHOX4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 19:56:15 -0400
Received: from adsl-209-204-138-32.sonic.net ([209.204.138.32]:50306 "EHLO
	server.home") by vger.kernel.org with ESMTP id S267285AbUHOX4G
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 19:56:06 -0400
Date: Sun, 15 Aug 2004 16:55:57 -0700 (PDT)
From: Christoph Lameter <christoph@lameter.com>
X-X-Sender: christoph@server.home
To: Andi Kleen <ak@muc.de>
cc: Christoph Lameter <clameter@sgi.com>, linux-ia64@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: page fault fastpath: Increasing SMP scalability by introducing
  pte locks?
In-Reply-To: <m31xi8dkm2.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.58.0408151654240.4346@server.home>
References: <2ttIr-2e4-17@gated-at.bofh.it> <2tzE4-6sw-25@gated-at.bofh.it>
 <2tCiw-8pK-1@gated-at.bofh.it> <m31xi8dkm2.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: -4.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004, Andi Kleen wrote:

> Christoph Lameter <clameter@sgi.com> writes:
>
> > On Sun, 15 Aug 2004, David S. Miller wrote:
> >
> >>
> >> Is the read lock in the VMA semaphore enough to let you do
> >> the pgd/pmd walking without the page_table_lock?
> >> I think it is, but just checking.
> >
> > That would be great.... May I change the page_table lock to
> > be a read write spinlock instead?
>
> That's probably not a good idea. r/w locks are extremly slow on
> some architectures. Including ia64.

I was thinking about a read write spinlock not an readwrite
semaphore. Look at include/asm-ia64/spinlock.h.
The implementations are almost the same. Are you sure
about this?

