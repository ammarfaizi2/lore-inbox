Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262314AbSKYBX4>; Sun, 24 Nov 2002 20:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262322AbSKYBX4>; Sun, 24 Nov 2002 20:23:56 -0500
Received: from dp.samba.org ([66.70.73.150]:54484 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S262314AbSKYBXz>;
	Sun, 24 Nov 2002 20:23:55 -0500
Date: Mon, 25 Nov 2002 12:26:58 +1100
From: Rusty Russell <rusty@rustcorp.com.au>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org, John Levon <levon@movementarian.org>
Subject: Re: New module loader makes kernel debugging much harder
Message-Id: <20021125122658.0bb41aed.rusty@rustcorp.com.au>
In-Reply-To: <25797.1038100726@ocs3.intra.ocs.com.au>
References: <20021124010617.GA58002@compsoc.man.ac.uk>
	<25797.1038100726@ocs3.intra.ocs.com.au>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Nov 2002 12:18:46 +1100
Keith Owens <kaos@ocs.com.au> wrote:
> One possibility the new loader opens up is the ability to replicate the
> pure module data (rodata and text) for each node of a NUMA box.  There
> is already an option to replicate the kernel text on each node to cut
> down inter-node traffic.  Replicating the pure module data would be
> nice as well.  I guarantee that will result in something that is not
> "simply mapped".

Ewww, you are a sick lad 8)

But I'm not sure that there is any interface which wouldn't break horribly
when faced with that possibility.

The patch to restore /proc/ksyms is trivial.  As is the addition of a start
entry /proc/modules.  When combined with rth's simplified loader, it should
be sufficient for both ksymoops and oprofile.

kgdb needs a patch to work, anyway: you might want to restore /proc/ksyms
in that patch?  (I don't use kgdb, so my ignorance here is complete).

Rusty.
-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
