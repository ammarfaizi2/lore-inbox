Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281645AbRKUHA6>; Wed, 21 Nov 2001 02:00:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281641AbRKUHAt>; Wed, 21 Nov 2001 02:00:49 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:18048 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281643AbRKUHAe>; Wed, 21 Nov 2001 02:00:34 -0500
Message-ID: <002501c1725a$19022a80$f5976dcf@nwfs>
From: "Jeff Merkey" <jmerkey@timpanogas.org>
To: "Jeff Merkey" <jmerkey@timpanogas.org>, <jmerkey@vger.timpanogas.org>,
        "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
Date: Tue, 20 Nov 2001 23:59:43 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > You are really a fucking pain in the ass to help Jeff.
>
> Dave,  I went and looked at this stuff.  I have been running this code for
> over a year on 2.4 and I AM NOT CREATING A SLAB CACHE TWICE!!!!
> I am building an NWFS module external of the kernel tree, and unless make
> dep
> has been run, the default behavior of the includes causes me to drop into
> the
> BUG() trap.

This is a bug in how these includes are structured.  It may be ok to leave
the damn
thing the way it is, but warn folks who build custom drivers (like the SCI
drivers I
maintain for Dolphin, NWFS, etc.) that their f_cking code will be broken and
generate these garbage errors if they have not run make dep against the tree
they
try to build against.

I would not have expected you or most LKML folks to have seen this, since
you live
in a world where everything is in the kernel tree.   I am telling you there
is a problem there,
and it can bite.  After I build this module (since the generated code thatr
ends up in
the external module is crap) it will routinely crash over and over gain
until it gets rebuilt
against a kernel that has had make dep (and make bzImage) run against it.

Jeff

>
> Jeff
>
>
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
>

