Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbVJJOy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbVJJOy1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 10:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbVJJOy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 10:54:27 -0400
Received: from qproxy.gmail.com ([72.14.204.200]:17904 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750828AbVJJOyZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 10:54:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ghet/cu0Qotwt8CPGCBQ7vJKRsZGnZgd5RSDb3q8zfJVqrqwGZpEeg/MvQV3IGKimIrrt5kFpDRlYg7nQkXcpYAp5V76Zs7RIngYkpxCg78Nj8SL5lT7lqVUiPSMhEKiQKsZC6U3dQvJNxdIGaImqf9aqG4Tgvj/Od0gBMPTf0M=
Message-ID: <d120d5000510100754r6012eba5ge088d4307c8e28bf@mail.gmail.com>
Date: Mon, 10 Oct 2005 09:54:24 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH2 6/6] isicom: More whitespaces and coding style
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <xslaby@fi.muni.cz>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <4af2d03a0510100250r58fb24f1l1067bf5ad54bb659@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051009194241.4821E22AF10@anxur.fi.muni.cz>
	 <200510092305.58010.dtor_core@ameritech.net>
	 <4af2d03a0510100250r58fb24f1l1067bf5ad54bb659@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/05, Jiri Slaby <jirislaby@gmail.com> wrote:
> On 10/10/05, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > On Sunday 09 October 2005 14:42, Jiri Slaby wrote:
> > > More whitespaces and coding style
> > >
> > > Wrap all the code to 80 chars on a line.
> > > Some `}\nelse' changed to `} else'.
> > > Clean whitespaces in header file.
> > >
> > > Generated in 2.6.14-rc2-mm2 kernel version
> > >
> > > Signed-off-by: Jiri Slaby <xslaby@fi.muni.cz>
> > >
> > > ---
> > >  drivers/char/isicom.c  |  148 +++++++++++++++++++++++-------------------------
> > >  include/linux/isicom.h |   21 +++----
> > >  2 files changed, 82 insertions(+), 87 deletions(-)
> > >
> > > diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
> > > --- a/drivers/char/isicom.c
> > > +++ b/drivers/char/isicom.c
> > > @@ -467,33 +467,36 @@ static void isicom_tx(unsigned long _dat
> > >               residue = NO;
> > >               wrd = 0;
> > >               while (1) {
> > > -                     cnt = min_t(int, txcount, (SERIAL_XMIT_SIZE - port->xmit_tail));
> > > +                     cnt = min_t(int, txcount, (SERIAL_XMIT_SIZE
> > > +                                     - port->xmit_tail));
> >
> > I am sorry but do you really consider the new form more readable?
> Yes, on the terminal it seems much more better than here and than before.
> But if you have some better idea how to do it, tell us and I will apply it.

At the minimum you could break at the last comma and not in the middle
of expression.

You could also take that block of code and split it to isicom_tx(),
isicom_port_tx() and isicom_chunk_tx(). That would save you couple if
identation levels and allow you to keep the code readable within 80
columns.

Just out of curiosity - was it run through Lindent or reformatted by
hand? The thing is - it might be not readable at 80 columns but I
could expand my terminal and get a decent results. Now it may be
better at 80 columns but no level of resizing terminal will make it
better.

--
Dmitry
