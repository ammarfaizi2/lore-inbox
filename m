Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSKJC7a>; Sat, 9 Nov 2002 21:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263208AbSKJC7a>; Sat, 9 Nov 2002 21:59:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:20552 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S263204AbSKJC73>; Sat, 9 Nov 2002 21:59:29 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Jeff Garzik <jgarzik@pobox.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Andy Pfiffer <andyp@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       <lkcd-general@lists.sourceforge.net>,
       <lkcd-devel@lists.sourceforge.net>
Subject: Re: [lkcd-devel] Re: What's left over.
References: <Pine.LNX.4.33L2.0211091533260.10722-100000@dragon.pdx.osdl.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 09 Nov 2002 19:58:25 -0700
In-Reply-To: <Pine.LNX.4.33L2.0211091533260.10722-100000@dragon.pdx.osdl.net>
Message-ID: <m1bs4ycer2.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> {warning: cc: list too large :}
> 
> On 9 Nov 2002, Eric W. Biederman wrote:
> 
> | There are two cases I am seeing users wanting.
> | 1) Load a new kernel on panic.
> |    - Extra care must be taken so what broke the first kernel does
> |      not break this one, and so that the shards of the old kernel
> |      do not break it.
> |    - Care must be taken so that loading the second kernel does not
> |      erase valuable data that is desirable to place in a crash dump.
> |    - This kernel cannot live at the same address as the old one, (at
> |      least not initially).
> 
> Conceptually we would like a new kernel on panic, although
> I doubt that it's normally safe to "load a new kernel on panic."
> Or maybe it depends on the definition of "load."
> 
> What I'm trying to say is that I think the new kernel must
> already be loaded when the panic happens.
> Is that what you describe later (below)?

Yes that was my meaning.   The new kernel must be preloaded.
And only started on panic.
