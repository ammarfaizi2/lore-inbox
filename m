Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272246AbTG1Biy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272231AbTG1ABl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:41 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272932AbTG0XBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:35 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: "David S. Miller" <davem@redhat.com>
Cc: arjanv@redhat.com, torvalds@transmeta.com, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Remove module reference counting. 
In-reply-to: Your message of "Fri, 25 Jul 2003 10:47:38 MST."
             <20030725104738.7ffbc118.davem@redhat.com> 
Date: Mon, 28 Jul 2003 04:50:19 +1000
Message-Id: <20030727193919.671CA2C086@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030725104738.7ffbc118.davem@redhat.com> you write:
> On Fri, 25 Jul 2003 04:00:18 +1000
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> 
> > 	If module removal is to be a rare and unusual event, it
> > doesn't seem so sensible to go to great lengths in the code to handle
> > just that case.  In fact, it's easier to leave the module memory in
> > place, and not have the concept of parts of the kernel text (and some
> > types of kernel data) vanishing.
> > 
> > Polite feedback welcome,
> 
> I'm ok with this, with one possible enhancement.
> 
> How about we make ->cleanup() return a boolean, which if true
> causes the caller to do the module_free()?

Some "I am the perfect module" flag would probably cause less
breakage.  But, I'm not sure even that is worth it.

Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
