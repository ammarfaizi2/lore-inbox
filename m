Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262456AbSI3QZo>; Mon, 30 Sep 2002 12:25:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262465AbSI3QZo>; Mon, 30 Sep 2002 12:25:44 -0400
Received: from [198.149.18.6] ([198.149.18.6]:14241 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262456AbSI3QZm>;
	Mon, 30 Sep 2002 12:25:42 -0400
Date: Mon, 30 Sep 2002 19:45:29 -0400
From: Christoph Hellwig <hch@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: lord@sgi.com, Arjan van de Ven <arjanv@redhat.com>, cw@f00f.org,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] smptimers, old BH removal, tq-cleanup, 2.5.39
Message-ID: <20020930194529.A15138@sgi.com>
Mail-Followup-To: Christoph Hellwig <hch@sgi.com>,
	Ingo Molnar <mingo@elte.hu>, lord@sgi.com,
	Arjan van de Ven <arjanv@redhat.com>, cw@f00f.org,
	linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@transmeta.com>
References: <20020930193713.A13195@sgi.com> <Pine.LNX.4.44.0209301835190.18614-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0209301835190.18614-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Sep 30, 2002 at 06:38:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 30, 2002 at 06:38:03PM +0200, Ingo Molnar wrote:
> see the workqueues patch i posted a couple of minutes ago. Does this solve
> XFS's problems?

Not exactly.  All your work on one queue is internally serialize.  An
totally unserialized workqueue would be best for XFS.

> why is it ugly? I can add a simple interface to the workqueues subsystem
> that will bind the XFS worker threads to given sets of CPUs. That should
> give you per-CPU workqueues, with separate per-CPU locking.

That would also work, but would require more code in XFS than my
above suggestion.

