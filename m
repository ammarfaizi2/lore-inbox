Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965431AbWI0HlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965431AbWI0HlJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 03:41:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965432AbWI0HlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 03:41:09 -0400
Received: from colin.muc.de ([193.149.48.1]:53764 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S965431AbWI0HlI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 03:41:08 -0400
Date: 27 Sep 2006 09:41:07 +0200
Date: Wed, 27 Sep 2006 09:41:07 +0200
From: Andi Kleen <ak@muc.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Don Zickus <dzickus@redhat.com>
Subject: Re: [PATCH] x86: Allow users to force a panic on NMI
Message-ID: <20060927074107.GA62414@muc.de>
References: <200609262259.k8QMxxa9012876@hera.kernel.org> <20060926165857.4bf90fd6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060926165857.4bf90fd6.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 04:58:57PM -0700, Andrew Morton wrote:
> On Tue, 26 Sep 2006 22:59:59 GMT
> Linux Kernel Mailing List <linux-kernel@vger.kernel.org> wrote:
> 
> > --- a/kernel/panic.c
> > +++ b/kernel/panic.c
> > @@ -21,6 +21,7 @@ #include <linux/kexec.h>
> >  #include <linux/debug_locks.h>
> >  
> >  int panic_on_oops;
> > +int panic_on_unrecovered_nmi;
> >  int tainted;
> >  static int pause_on_oops;
> >  static int pause_on_oops_flag;
> 
> Is visible to all architectures.

Ok, adding a #ifdef

-Andi
