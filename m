Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbUK0MO4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbUK0MO4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 07:14:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261196AbUK0MO4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 07:14:56 -0500
Received: from pop.gmx.de ([213.165.64.20]:26498 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261194AbUK0MOx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 07:14:53 -0500
X-Authenticated: #15156664
Message-ID: <001601c4d47a$bcfb4920$8511050a@alexs>
From: "Alexander Stohr" <alexander.stohr@gmx.de>
To: "David Woodhouse" <dwmw2@infradead.org>, "Matthew Wilcox" <matthew@wil.cx>
Cc: "David Howells" <dhowells@redhat.com>,
       "Alexandre Oliva" <aoliva@redhat.com>, <torvalds@osdl.org>,
       <hch@infradead.org>, <linux-kernel@vger.kernel.org>,
       <libc-alpha@sources.redhat.com>
References: <20041125210137.GD2849@parcelfarce.linux.theplanet.co.uk> <19865.1101395592@redhat.com> <orvfbtzt7t.fsf@livre.redhat.lsd.ic.unicamp.br> <12983.1101470307@redhat.com> <1101470443.8191.9438.camel@hades.cambridge.redhat.com> <20041126141935.GA29035@parcelfarce.linux.theplanet.co.uk> <1101479593.8191.9555.camel@hades.cambridge.redhat.com>
Subject: Re: [RFC] Splitting kernel headers and deprecating __KERNEL__
Date: Sat, 27 Nov 2004 13:10:40 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Matthew Wilcox wrote:
> > Indeed.  We could also make this transparent to userspace by using a script
> > to copy the user-* headers to /usr/include.  Something like this:

some administrator would like to only create symlinks for saving disk space.

others would like a true "install" with copying files so that they can delete
the kernel sources anytime they do want.

for me i would install all those kernel realted files into 
the well known /lib/modules/<kernel-version>. 
so its a no question that a single kernel install 
can be cleaned up by deleting those dir recursively.

the only part remaining somewhere else in the filesystem
would then be /boot/bzImage since booting is a special case.
there are several architectures where the bzImage is be able 
to reside in /lib/modules/... but there are others archs as well.

David Woodhouse wrote:
> Matthew Wilcox wrote:
> > If we really wanted to get fancy, we could also sed __u32 to uint32_t.
> > But that would probably cause more pain, confusion, hurt and bad feeling
> > than I'd ever want to be responsible for.
> 
> Also true. Let's just use the standard types in the first place and not
> screw around with having to fix it up later.

uint32_t is the type you should get when using the standarized statement
  #include <stdint.h>
Am i right? Does that header belong to the international C99 Standard?
So you are suggesting the kernel interface should stick to that standard?

Changing it that way would hit a noticeable amount of non kernel code.
Lets consider the opposite point of view. If we do postpone such a
change to the standards for some 3 to 10 more years, then i expect
the impact on software and problem for getting it solve is bigger.

Maybe that sort of change is something qualified for beeing done 
inside a true development kernel tree like Linux 2.7.xx which might
then beeing qualified for getting a Linux 3.0.0 release kernel tree.

-Alex.

