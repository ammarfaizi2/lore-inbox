Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280769AbRKGEa6>; Tue, 6 Nov 2001 23:30:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280762AbRKGEas>; Tue, 6 Nov 2001 23:30:48 -0500
Received: from [209.195.52.30] ([209.195.52.30]:4881 "HELO [209.195.52.30]")
	by vger.kernel.org with SMTP id <S280761AbRKGEai>;
	Tue, 6 Nov 2001 23:30:38 -0500
From: David Lang <david.lang@digitalinsight.com>
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: Robert Love <rml@tech9.net>, torvalds@transmeta.com,
        Mike Fedyk <mfedyk@matchmail.com>, Terminator <jimmy@mtc.dhs.org>,
        linux-kernel@vger.kernel.org
Date: Tue, 6 Nov 2001 20:06:40 -0800 (PST)
Subject: Re: Are -final releases realy FINAL? (Was Re: kernel 2.4.14 compiling
 fail for loop device)
In-Reply-To: <20011107091314.A11202@bee.lk>
Message-ID: <Pine.LNX.4.40.0111062003220.955-100000@dlang.diginsite.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linus goofed when he missed the two refrences to this function.

however as he pointed out earlier it was a function that could never get
called.

removing a function that can never be called comes pretty close to a
trivial change to me.

even with this mistake it far fewer changes then we have seen in some of
the past -final releases so at the very least it's a step in the right
direction.

David Lang

On Wed, 7 Nov 2001, Anuradha Ratnaweera wrote:

> Date: Wed, 7 Nov 2001 09:13:14 +0600
> From: Anuradha Ratnaweera <anuradha@gnu.org>
> To: Robert Love <rml@tech9.net>, torvalds@transmeta.com
> Cc: Mike Fedyk <mfedyk@matchmail.com>, Terminator <jimmy@mtc.dhs.org>,
>      linux-kernel@vger.kernel.org
> Subject: Are -final releases realy FINAL? (Was Re: kernel 2.4.14
>     compiling fail for loop device)
>
> On Mon, Nov 05, 2001 at 11:02:36PM -0500, Robert Love wrote:
> >
> > On Mon, 2001-11-05 at 22:43, Mike Fedyk wrote:
> > >
> > > Did anyone have this problem with pre8???
> >
> > Nope, it was added post-pre8 to final.  The deactivate_page function was
> > removed completely.
>
> Look, Linus.  Things should _not_ happen this way.
>
> Why do we add non-trivial changes when going from last -preX of a test kernel
> series to -final?
>
> Please make the last stable -preX the -final _without_ any changes.  This is
> the third time this caused problem in recent times (2.4.11-dontuse, parport
> compile problems and now loop.o), and why don't we learn from previous
> mistakes?
>
> Isn't it stupid that some tarballs in the /pub/linux/kernel/v2.4/ do not even
> compile, while those in /pub/linux/kernel/testing/ does?
>
> Regards,
>
> Anuradha
>
> --
>
> Debian GNU/Linux (kernel 2.4.14-pre7)
>
> I cannot conceive that anybody will require multiplications at the rate
> of 40,000 or even 4,000 per hour ...
> 		-- F. H. Wales (1936)
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
