Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266228AbSKZHA5>; Tue, 26 Nov 2002 02:00:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266233AbSKZHA5>; Tue, 26 Nov 2002 02:00:57 -0500
Received: from ns.suse.de ([213.95.15.193]:64523 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S266228AbSKZHA4>;
	Tue, 26 Nov 2002 02:00:56 -0500
To: Patrick Finnegan <pat@purdueriots.com>
Cc: linux-kernel@vger.kernel.org, jdike@karaya.com
Subject: Re: uml-patch-2.5.49-1
References: <20021126061021.GA17959@wotan.suse.de.suse.lists.linux.kernel> <Pine.LNX.4.44.0211260159440.7540-100000@ibm-ps850.purdueriots.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 26 Nov 2002 08:08:12 +0100
In-Reply-To: Patrick Finnegan's message of "26 Nov 2002 08:03:06 +0100"
Message-ID: <p73r8d8u7tv.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Finnegan <pat@purdueriots.com> writes:

> That's just one example... the idea is that you want maximal separation
> between the guest OS's apps and the host OS.  Sort of like "VM" on IBM's
> series of mainframe architecures.  Of course, that's virtualization done
> in hardware not in software, but the principles are the same; you want a
> maximal amount of separation between the layers.

As an "idea" it doesn't make much sense for me. An mm does tie up
considerable amounts of unswappable host memory (page tables, mm_struct), 
which could be used for a DoS without too many problems. The separation 
you are asking for just isn't there with UML. The same applies to other 
resources used by UML.

-Andi
