Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbTIOVtx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Sep 2003 17:49:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261632AbTIOVtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Sep 2003 17:49:53 -0400
Received: from pizda.ninka.net ([216.101.162.242]:7831 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261628AbTIOVtw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Sep 2003 17:49:52 -0400
Date: Mon, 15 Sep 2003 14:38:13 -0700
From: "David S. Miller" <davem@redhat.com>
To: =?ISO-8859-1?Q?Dani=EBl?= Mantione <daniel@deadlock.et.tudelft.nl>
Cc: mroos@linux.ee, linux-kernel@vger.kernel.org
Subject: Re: atyfb still broken on 2.4.23-pre4 (on sparc64)
Message-Id: <20030915143813.2011187f.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0309151225300.24675-100000@deadlock.et.tudelft.nl>
References: <20030915011159.250f3346.davem@redhat.com>
	<Pine.LNX.4.44.0309151225300.24675-100000@deadlock.et.tudelft.nl>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Sep 2003 12:58:26 +0200 (CEST)
Daniël Mantione <daniel@deadlock.et.tudelft.nl> wrote:

> > Please, can we revert your changes if we can't fix Sparc quickly?
> 
> Well, the problem is, there are really a *lot* of chips sold which I
> fixed.

And you broke one of the primary users of the atyfb driver,
the sparc64 platform.

We don't even get a console if this driver is non-functional,
that's the part you don't understand.  On x86 one can at least
use the VGA or Vesa drivers, we simply don't have that option.

So effectively, you've made 2.4.23-preX completely nonusable for
the vast majority of sparc64 users.

> Well, the only way to fix this is to work with you of course.

Your change is a major regression and we should revert it until
the kinks are worked out.
