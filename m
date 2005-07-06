Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262302AbVGFOZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262302AbVGFOZr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 10:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262295AbVGFOWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 10:22:54 -0400
Received: from [203.171.93.254] ([203.171.93.254]:44974 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262289AbVGFKMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 06:12:30 -0400
Subject: Re: [PATCH] [48/48] Suspend2 2.1.9.8 for 2.6.12:
	624-filewriter.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pekka Enberg <penberg@gmail.com>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <84144f02050706030779f083fd@mail.gmail.com>
References: <11206164393426@foobar.com> <11206164443920@foobar.com>
	 <84144f02050706030779f083fd@mail.gmail.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120644824.4860.65.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 20:13:44 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Thanks very much for all your reading and commenting. I really
appreciate it. By the way, you do want replies sent to both addresses?

This one is contributed code. I haven't had or needed an update since it
was added though, so I guess I could reindent it. Will do.

Regards,

Nigel

On Wed, 2005-07-06 at 20:07, Pekka Enberg wrote:
> On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> > diff -ruNp 625-crypto-api-work.patch-old/crypto/lzf.c 625-crypto-api-work.patch-new/crypto/lzf.c
> > --- 625-crypto-api-work.patch-old/crypto/lzf.c  1970-01-01 10:00:00.000000000 +1000
> > +++ 625-crypto-api-work.patch-new/crypto/lzf.c  2005-07-05 23:57:15.000000000 +1000
> > +static int lzf_compress(void * context, const u8 *in_data, unsigned int in_len,
> > +                           u8 *out_data, unsigned int *out_len)
> > +{
> > +  struct lzf_ctx * ctx = (struct lzf_ctx *) context;
> > +  const u8 **htab = ctx->hbuf;
> > +  const u8 **hslot;
> > +  const u8 *ip = in_data;
> > +        u8 *op = out_data;
> > +  const u8 *in_end  = ip + in_len;
> > +        u8 *out_end = op + *out_len - 3;
> > +  const u8 *ref;
> > +
> > +  unsigned int hval = FRST (ip);
> > +  unsigned long off;
> > +           int lit = 0;
> > +
> > +       if (ctx->first_call) {
> > +               ctx->first_call = 0;
> > +       }
> > +#if INIT_HTAB
> 
> [snip, snip]
> 
> scripts/Lindent, please.
> 
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

