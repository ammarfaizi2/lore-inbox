Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263272AbTDGF7J (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 01:59:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263273AbTDGF7J (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 01:59:09 -0400
Received: from dp.samba.org ([66.70.73.150]:37071 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S263272AbTDGF7H (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Apr 2003 01:59:07 -0400
From: Paul Mackerras <paulus@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16017.2065.635724.992168@argo.ozlabs.ibm.com>
Date: Mon, 7 Apr 2003 15:09:37 +1000
To: Christoph Hellwig <hch@infradead.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Fabrice Bellard <fabrice.bellard@free.fr>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] Qemu support for PPC
In-Reply-To: <20030407065813.A27933@infradead.org>
References: <20030407024858.C32422C014@lists.samba.org>
	<20030407065813.A27933@infradead.org>
X-Mailer: VM 7.14 under Emacs 21.2.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig writes:

> On Mon, Apr 07, 2003 at 12:40:38PM +1000, Rusty Russell wrote:
> > Paul, is this OK?
> > 
> > I'd like it in 2.4.21 if possible.
> 
> Please use sys_personality from userland. 

sys_personality will fail if there isn't an exec_domain registered for
the personality you want.  The *whole* *point* of Rusty's patch is to
add an execution domain for x86 emulation so we *can* do sys_personality.

Did you actually look at the patch, or was your mail just a knee-jerk?

> And not, I don't think it should
> go into 2.4.21.  Get it into 2.5 first.

Why?  It's a well-contained patch that affects very little outside its
own area, and is quite similar to other things that have been there
for ages.  Anyway, it's not your call.

Paul.
