Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261507AbVBAC2n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261507AbVBAC2n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 21:28:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVBAC2n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 21:28:43 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:29122 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261507AbVBAC2e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 21:28:34 -0500
Subject: Re: [RFC] shared subtrees
From: Ram <linuxram@us.ibm.com>
To: Mike Waychison <Michael.Waychison@Sun.COM>
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <41FABD4E.6050701@sun.com>
References: <20050113221851.GI26051@parcelfarce.linux.theplanet.co.uk>
	 <41FABD4E.6050701@sun.com>
Content-Type: text/plain
Organization: IBM 
Message-Id: <1107224911.8118.65.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 31 Jan 2005 18:28:31 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-01-28 at 14:31, Mike Waychison wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Al Viro wrote:
> 
> > OK, here comes the first draft of proposed semantics for subtree
> > sharing.  What we want is being able to propagate events between
> > the parts of mount trees.  Below is a description of what I think
> > might be a workable semantics; it does *NOT* describe the data
> > structures I would consider final and there are considerable
> > areas where we still need to figure out the right behaviour.
> > 
> 
> Okay, I'm not convinced that shared subtrees as proposed will work well
> with autofs.
> 
> The idea discussed off-line was this:
> 
> When you install an autofs mountpoint, on say /home, a daemon is started
> to service the requests.  As far as the admin is concerned, an fs is
> mounted in the current namespace, call it namespaceA.  The daemon
> actually runs in it's one private namespace: call it namespaceB.
> namespaceB receives a new autofs filesystem: call it autofsB.  autofsB
> is in it's own p-node.  namespaceA gets an autofsA on /home as well, and
> autofsA is 'owned' by autofsB's p-node.

Mike, multiple parsing through the problem definition, still did not
make the problem clear. What problem is autofs trying to solve using
namespaces?

My guess is you dont want to see a automount taking place in namespaceA,
when a automount takes place in namespaceB, even though
the automount-point is in a shared subtree?

Sorry don't understand automount's requirement in the first place,
RP

> 
> So:
 ..snip...

