Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbTJACmM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 22:42:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbTJACmM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 22:42:12 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:23686 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S261355AbTJACmM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 22:42:12 -0400
Date: Wed, 1 Oct 2003 03:41:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Hugh Dickins <hugh@veritas.com>
Cc: Klaus Dittrich <kladit@t-online.de>,
       linux mailing-list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>, "Hu, Boris" <boris.hu@intel.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: 2.6.0-test6 oops futex"
Message-ID: <20031001024130.GC32209@mail.shareable.org>
References: <20030930084853.GD26649@mail.jlokier.co.uk> <Pine.LNX.4.44.0309302141220.4388-100000@localhost.localdomain> <20031001010125.GB32209@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031001010125.GB32209@mail.shareable.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Solutions are to call hash_futex() inside the lock, or store the
> hash result inside futex_q, and read it inside the lock.

What _am_ I talking about.  Can't call hash_futex() inside the lock,
it's needed to choose the lock ;)

Keeping the split locks is going to be tricky - all due to futex_requeue.

-- Jamie
