Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265718AbUFXPap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265718AbUFXPap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 11:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265701AbUFXPap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 11:30:45 -0400
Received: from fw.osdl.org ([65.172.181.6]:22696 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265718AbUFXPak (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 11:30:40 -0400
Date: Thu, 24 Jun 2004 08:30:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arjan van de Ven <arjanv@redhat.com>
cc: Jakub Jelinek <jakub@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: using gcc built-ins for bitops?
In-Reply-To: <20040624123515.GD21376@devserv.devel.redhat.com>
Message-ID: <Pine.LNX.4.58.0406240827570.1688@ppc970.osdl.org>
References: <20040624070936.GB30057@devserv.devel.redhat.com>
 <20040624020022.0601d4ae.akpm@osdl.org> <20040624113151.GA21376@devserv.devel.redhat.com>
 <20040624120534.GW21264@devserv.devel.redhat.com>
 <20040624123515.GD21376@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 24 Jun 2004, Arjan van de Ven wrote:
> 
> It's actually fine; the architecture first needs to include this file and
> there it can use the proper ifdefs; the functions themselves don't matter,
> only when they can be used, and the arch still controls that.

And my argument is: what the hell does this _buy_ us, except for extra 
complexity, and even more code dependence on different versions of gcc.

I don't want the extra code-paths and magic #ifdef's unless there's a 
clear improvement somewhere. And quite frankly, I don't see that being the 
case for something like ffs.

		Linus
