Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbSLXGZD>; Tue, 24 Dec 2002 01:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267032AbSLXGZD>; Tue, 24 Dec 2002 01:25:03 -0500
Received: from samael.donpac.ru ([195.161.172.239]:7430 "EHLO samael.donpac.ru")
	by vger.kernel.org with ESMTP id <S267030AbSLXGZC> convert rfc822-to-8bit;
	Tue, 24 Dec 2002 01:25:02 -0500
From: "Andrey Panin" <pazke@orbita1.ru>
Date: Tue, 24 Dec 2002 09:28:35 +0300
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] irq handling code consolidation (common part)
Message-ID: <20021224062835.GC1222@pazke>
Mail-Followup-To: Miles Bader <miles@gnu.org>, linux-kernel@vger.kernel.org
References: <20021224060331.GA1090@pazke> <buok7i0szhf.fsf@mcspd15.ucom.lsi.nec.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <buok7i0szhf.fsf@mcspd15.ucom.lsi.nec.co.jp>
User-Agent: Mutt/1.3.28i
X-Uname: Linux 2.4.20aa1 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2002 at 03:27:40PM +0900, Miles Bader wrote:
> "Andrey Panin" <pazke@orbita1.ru> writes:
> > this patch moves some common parts of irq handling code to one place.
> > Arch specific patches will follow. Patch for i386 is tested and performed 
> > well, but other arch specific patched are not. Please take a look.
> 
> Hmm, well it looks like it will work perfectly with the v850 (which
> makes sense as it's mostly a copy of the i386 code).
I have a patch for v850 already, I'll send it soon.
 
> What about request_irq/setup_irq?  The majority of architectures use
> exactly the same code as i386 for these; a few do not, so perhaps this
> is a case where a HAVE_ARCH_... define could be used.
> 
> [setup_irq even has this comment:
> 
>    /* this was setup_x86_irq but it seems pretty generic */
>    int setup_irq(unsigned int irq, struct irqaction * new)
> ]
It will be the next part of work. I'm changing my job now and
lack of time limits my perfomance :(

> -Miles
> -- 
> Come now, if we were really planning to harm you, would we be waiting here, 
>  beside the path, in the very darkest part of the forest?

-- 
Andrey Panin		| Embedded systems software developer
pazke@orbita1.ru	| PGP key: wwwkeys.pgp.net
