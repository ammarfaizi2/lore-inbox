Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751051AbWCGLZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751051AbWCGLZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 06:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752152AbWCGLZV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 06:25:21 -0500
Received: from smtp.osdl.org ([65.172.181.4]:39866 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751051AbWCGLZV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 06:25:21 -0500
Date: Tue, 7 Mar 2006 03:23:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.16-rc5-mm3
Message-Id: <20060307032330.2a80c528.akpm@osdl.org>
In-Reply-To: <20060307112206.GA29565@infradead.org>
References: <20060307021929.754329c9.akpm@osdl.org>
	<20060307112206.GA29565@infradead.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Tue, Mar 07, 2006 at 02:19:29AM -0800, Andrew Morton wrote:
> > +ia64-dont-report-sn2-or-summit-hardware-as-an-error.patch
> > +sgi-sn-drivers-dont-report-sn2-hardware-as-an-error.patch
> > 
> >  ia64 fixes
> 
> These are wrong.  The hardware is not available so -ENODEV is the right
> return value.  Especially in the mmtimer case this is a real bug because
> the module would stay loaded despite not beeing initialized and uneeded,
> in the others it's just cosmetical but still wrong.

OK, thanks, gone.

I changed that initcall warning so it doesn't warn about -ENODEV unless you
specified initcall_debug.

