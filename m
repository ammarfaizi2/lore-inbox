Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262135AbVF0XZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262135AbVF0XZH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 19:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVF0XYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 19:24:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53436 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262011AbVF0XXY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 19:23:24 -0400
Date: Mon, 27 Jun 2005 16:23:03 -0700
From: Andrew Morton <akpm@osdl.org>
To: Hans Reiser <reiser@namesys.com>
Cc: tytso@mit.edu, mjt@nysv.org, vonbrand@inf.utfsm.cl, ninja@slaphack.com,
       alan@lxorguk.ukuu.org.uk, jgarzik@pobox.com, hch@infradead.org,
       linux-kernel@vger.kernel.org, reiserfs-list@namesys.com, lord@xfs.org
Subject: Re: reiser4 merging action list
Message-Id: <20050627162303.156551b4.akpm@osdl.org>
In-Reply-To: <42C084F1.70607@namesys.com>
References: <42BB7B32.4010100@slaphack.com>
	<200506240334.j5O3YowB008100@laptop11.inf.utfsm.cl>
	<20050627092138.GD11013@nysv.org>
	<20050627124255.GB6280@thunk.org>
	<42C0578F.7030608@namesys.com>
	<20050627212628.GB27805@thunk.org>
	<42C084F1.70607@namesys.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> wrote:
>
> 
> Andrew asked me to put together a list of things that need to be done
> before merging:

Thanks.

As I said to Hans, if we can get a list of bullet-point actions nailed down
and agreed to then we have an uncontroversial path to happiness and a
merge.  Let's get down and concentrate on technical specifics.

Hans, please maintain this list and republish it as we work through things.

>     * VFS will dispatch directly to the method of the plugin for the
> *_operations methods.  This requires duplicating to all plugin methods
> the common code currently used by all reiser4 plugins for a given
> method.  It has the desirable side effect of making the methods more
> fully self-contained, which is somethng I had wanted two years ago and
> was a little sad to not get, and the cost of duplicating some code. 
> Since not all plugin methods are *_operations, it means we have two
> structures with duplicated data, and duplicate data that must be in sync
> at all times is classical badness in programming technique (see Codd and
> normalization).                                 vs owns this task
> 
>     * review all sparse complaints, and revise as appropriate. 
> 
>     * panic and code beauty: everyone agrees that having function, file,
> and line added to reiser4_panic output hurts nothing (I hope).  Everyone
> agrees that restarting the machine without an error message seems like a
> useless option to allow.   Much else was argued, not sure if anything
> was a consensus view.  Various detail improvements were suggested by
> Pecca, and I agreed with half of them.
> 
> 
>    * metafiles should be disabled until we can present code that works
> right.  Half the list thinks we cannot solve the cycles problem ever. 
> Disable metafiles and postpone problem until working code, or the
> failure to produce it, makes it possible to do more than rant at each
> other.  This is currently already done in the -mm patches, but is
> mentioned lest someone think it forgotten.
> 
>    * update the locking documentation
> 

There's also the custom list, hash and debug code.  We should either

a) remove them or

b) generify them and submit as standalone works or

c) justify them as custom-to-reiser4 and leave them as-is.


