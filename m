Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992533AbWJTHMK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992533AbWJTHMK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 03:12:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992534AbWJTHMK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 03:12:10 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:6284 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S2992533AbWJTHMI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 03:12:08 -0400
Date: Fri, 20 Oct 2006 08:12:04 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Vasily Tarasov <vtaras@openvz.org>
Cc: Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jan Kara <jack@suse.cz>,
       Dmitry Mishin <dim@openvz.org>, Vasily Averin <vvs@sw.ru>,
       Kirill Korotaev <dev@openvz.org>,
       OpenVZ Developers List <devel@openvz.org>
Subject: Re: [PATCH] diskquota: 32bit quota tools on 64bit architectures
Message-ID: <20061020071204.GB29871@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Vasily Tarasov <vtaras@openvz.org>, Andi Kleen <ak@suse.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Jan Kara <jack@suse.cz>,
	Dmitry Mishin <dim@openvz.org>, Vasily Averin <vvs@sw.ru>,
	Kirill Korotaev <dev@openvz.org>,
	OpenVZ Developers List <devel@openvz.org>
References: <200610191232.k9JCW7CF015486@vass.7ka.mipt.ru> <p73hcy0b83k.fsf@verdi.suse.de> <200610200630.k9K6U4RU031798@vass.7ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200610200630.k9K6U4RU031798@vass.7ka.mipt.ru>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2006 at 10:30:04AM +0400, Vasily Tarasov wrote:
> Andi Kleen wrote:
> 
> <snip>
> > Thanks. But the code should be probably common somewhere in fs/*, not
> > duplicated.
> <snip>
> 
> Thank you for the comment!
> I'm not sure we should do it. If we move the code in fs/quota.c for example,
> than this code will be compiled for _all_ arhitectures, not only for x86_64 and ia64.
> Of course, we can surround this code by #ifdefs <ARCH>, but I thought this is 
> a bad style... Moreover looking through current kernel code, I found out that
> usually code is duplicated in such cases.
> 
> However, if you insist I'll modify the code! :)

I suspect a compat_x86.c file somehwere might make sense, as only x86 has
the wierd alignment rules, but we have two architectures that allow to run
x86 binaries with the compat subszstem.  Now the big question:  where should
we put this file?

> 
> Thank you.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
---end quoted text---
