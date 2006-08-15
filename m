Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030317AbWHOObV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030317AbWHOObV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 10:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030315AbWHOObV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 10:31:21 -0400
Received: from mail.fieldses.org ([66.93.2.214]:48870 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP
	id S1030313AbWHOObU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 10:31:20 -0400
Date: Tue, 15 Aug 2006 10:31:18 -0400
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Trond Myklebust <Trond.Myklebust@netapp.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: locks_insert_block: removing duplicated lock (pid=2711 0-9223372036854775807 type=1)
Message-ID: <20060815143118.GC4904@fieldses.org>
References: <9a8748490608100502wd9a097cwab80c662300020e8@mail.gmail.com> <9a8748490608150458t53da165cvca0f6bf71c25ed63@mail.gmail.com> <9a8748490608150502g30c2e566g7301ca5cc50778ce@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490608150502g30c2e566g7301ca5cc50778ce@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2006 at 02:02:50PM +0200, Jesper Juhl wrote:
> On 15/08/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >On 10/08/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >> I've got a server running 2.6.11.11 that just reported the following in 
> >dmesg :
> >>
> >> locks_insert_block: removing duplicated lock (pid=2711
> >> 0-9223372036854775807 type=1)
> >>
> >Still getting lots of these :
> >
> >Aug 15 13:53:01 server kernel: locks_insert_block: removing duplicated
> >lock (pid=3 0-9223372036854775807 type=1)
> >Aug 12 22:46:31 server kernel: locks_insert_block: removing duplicated
> >lock (pid=1036 0-9223372036854775807 type=1)
> >Aug 12 00:21:28 server kernel: locks_insert_block: removing duplicated
> >lock (pid=1020 0-9223372036854775807 type=1)
> >
> >What's the exact meaning of this?

I *think* that's harmless in that version of the code, though I'm not
sure.

Trond's made a bunch of lockd fixes since then (e.g. 09c7938c), which
probably fix it.

And that printk has been changed to a BUG(), so it better not be
triggered any more....  I certainly don't see how it could happen in the
current code.

--b.
