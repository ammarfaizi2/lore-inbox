Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261528AbVFEIbq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261528AbVFEIbq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 04:31:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261529AbVFEIbq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 04:31:46 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:54913
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S261528AbVFEIbn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 04:31:43 -0400
Subject: Re: patch] Real-Time Preemption, plist fixes
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org,
       Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>,
       Ingo Molnar <mingo@elte.hu>, Oleg Nesterov <oleg@tv-sign.ru>
In-Reply-To: <Pine.LNX.4.44.0506041748060.17923-100000@dhcp153.mvista.com>
References: <Pine.LNX.4.44.0506041748060.17923-100000@dhcp153.mvista.com>
Content-Type: text/plain
Organization: linutronix
Date: Sun, 05 Jun 2005 10:32:17 +0200
Message-Id: <1117960337.20785.251.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2005-06-04 at 17:53 -0700, Daniel Walker wrote:

> You mean really annoying in the plist code?

Usually I mean what I write.
 
> > 2. Add the proper list_head initializer in the replacement path.
> 
> Not sure what you mean here.

      list_replace_rcu(&pl->dp_node, &pl_new->dp_node);
+     INIT_LIST_HEAD(&pl->dp_node);

 
> > 4. Make plist_entry() work as expected by anybody who ever used
> > list_entry(). Add a plist_first_entry macro for those places where the
> > provided functionality was accidentaly correct.
> >
> I already released a patch to fix this.

Nice to know. Where ?

> > 5. Modify the comments in the header file to explain the real intention
> > of the implemenation.
>
> You should wait till it's stable before you finalize the documentation.

Thats plain wrong. Having explanations in place which do not match the
code is worse than no explanation at all.

tglx


