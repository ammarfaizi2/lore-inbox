Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131526AbRBJPfE>; Sat, 10 Feb 2001 10:35:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131577AbRBJPez>; Sat, 10 Feb 2001 10:34:55 -0500
Received: from smtp.mountain.net ([198.77.1.35]:52998 "EHLO riker.mountain.net")
	by vger.kernel.org with ESMTP id <S131526AbRBJPem>;
	Sat, 10 Feb 2001 10:34:42 -0500
Message-ID: <3A855F75.2C31D7D9@mountain.net>
Date: Sat, 10 Feb 2001 10:34:13 -0500
From: Tom Leete <tleete@mountain.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.1 i486)
X-Accept-Language: en-US,en-GB,en,fr,es,it,de,ru
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre Hedrick <andre@linux-ide.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Athlon-SMP compiles & runs. inline fns honored.
In-Reply-To: <3A8554FA.AB33BE05@mountain.net> <3A855A85.A33BBF7F@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> Tom Leete wrote:
> >
> > +
> > +#ifndef _LINUX_MM_H
> > +struct vm_area_struct;
> > +#endif
> > +
> Are the #ifndef's necessary?
> Could you try to remove the #ifndef and always declare the struct? gcc
> shouldn't complain.

Probably not necessary, but that seemed tidier if the struct definition is
available.

> 
> > +
> > +/* Try removing /linux/fs.h in capability.h first
> > +#ifndef _LINUX_CAPABILITY_H
> > +typedef struct bogus_cap_struct {
> > +       __u32 cap;
> > +} kernel_cap_t;
> > +#endif
> > +*/
> > +
> Is is possible to get rid of that one?
> What if somone modifies capability.h?

Yes, that's provisional and is superfluous if 'capability.h:17 #include
<linux/fs.h>' is to be removed. It is commented out in the preliminary
patch. Awaiting comment from the authors.

> 
> --
>         Manfred

After critique is in, I'll make a polished final version.

Thanks for the review,
Tom

-- 
The Daemons lurk and are dumb. -- Emerson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
