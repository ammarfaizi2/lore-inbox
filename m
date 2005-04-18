Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262019AbVDRKTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbVDRKTq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 06:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262020AbVDRKTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 06:19:46 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:23813 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262019AbVDRKTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 06:19:35 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Andreas Steinmetz <ast@domdv.de>
Subject: Re: [RFC][PATCH 2/4] AES assembler implementation for x86_64
Date: Mon, 18 Apr 2005 13:19:14 +0300
User-Agent: KMail/1.5.4
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       jmorris@redhat.com, davem@davemloft.net, ak@suse.de
References: <4262B6E9.8040400@domdv.de> <200504181118.50594.vda@ilport.com.ua> <42637775.8000904@domdv.de>
In-Reply-To: <42637775.8000904@domdv.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504181319.15708.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 April 2005 12:01, Andreas Steinmetz wrote:
> Denis Vlasenko wrote:
> > On Sunday 17 April 2005 22:20, Andreas Steinmetz wrote:
> > 
> >>The attached patch contains Gladman's in-kernel code for key schedule
> >>and table generation modified to fit to my assembler implementation,
> >>-- 
> >>Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
> > 
> > 
> > Patch contains a mix of several coding styles:
> >  
> > +/*
> > + * #define byte(x, nr) ((unsigned char)((x) >> (nr*8))) 
> > + */
> > +inline static u8
> > +byte(const u32 x, const unsigned n)
> > +{
> > +       return x >> (n << 3);
> > +}
> > 
> > what does const do here?
> 
> Taken 'as is' from current kernel sources, i,e, crypto/aes.c

"It's a cut-n-paste" is not a good argument here. You
are adding a _new file_ with your patch, it's okay to clean
it up while doing this. IOW: do not dup the mess.

OTOH, if _exactly the same file_ exist in i384 arch, then
you should not duplicate it at all. Find a way to use one file
for both arches.

Note that this is only my view, I can be wrong.
--
vda

