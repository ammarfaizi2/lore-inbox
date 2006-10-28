Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWJ1RHk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWJ1RHk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 13:07:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751188AbWJ1RHk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 13:07:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:30413 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751187AbWJ1RHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 13:07:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fEPaj4X+CazJDBSQBtSC08WvIXQEeipPGmngrQqcJwPZNpV83bQdFCoX9FIrOKKiMjTE06NUhGAVg4Q4HEy6UMSD+cXJoZSHrAZINZo+e+xq3Hd/Tw5EH/OvLKoGRTOycDdN82Wyi1BD3jkALI5rPmCvMFdKEfSMfr+i0uiJccc=
Message-ID: <9a8748490610281007s7964f0e6nd3982ed1882264f9@mail.gmail.com>
Date: Sat, 28 Oct 2006 19:07:37 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Randy Dunlap" <randy.dunlap@oracle.com>
Subject: Re: [PATCH] silence 'make xmldocs' warning by adding missing description of 'raw' in nand_base.c:1485
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       torvalds <torvalds@osdl.org>, akpm <akpm@osdl.org>
In-Reply-To: <20061027162116.deb9dafe.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200610272259.k9RMx3cq030980@hera.kernel.org>
	 <20061027162116.deb9dafe.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/10/06, Randy Dunlap <randy.dunlap@oracle.com> wrote:
> On Fri, 27 Oct 2006 22:59:03 GMT Linux Kernel Mailing List wrote:
>
> > commit efbfe96c5d839c367249bf1cd53249716450c0a2
> > tree 36a1a7d72586a2f8fd25feb225cd4e627cd275b3
> > parent 735a7ffb739b6efeaeb1e720306ba308eaaeb20e
> > author Jesper Juhl <jesper.juhl@gmail.com> 1161984287 +0200
> > committer Linus Torvalds <torvalds@g5.osdl.org> 1161988491 -0700
> >
> > [PATCH] silence 'make xmldocs' warning by adding missing description of 'raw' in nand_base.c:1485
> >
> > Add description of 'raw' in comments for
> > drivers/mtd/nand/nand_base.c::nand_write_page_syndrome() so 'make xmldocs'
> > will not spew a warning at us.
> >
> > Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
> > Acked-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> >
> >  drivers/mtd/nand/nand_base.c |    1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
> > index baece61..41bfcae 100644
> > --- a/drivers/mtd/nand/nand_base.c
> > +++ b/drivers/mtd/nand/nand_base.c
> > @@ -1479,6 +1479,7 @@ static void nand_write_page_syndrome(str
> >   * @buf:     the data to write
> >   * @page:    page number to write
> >   * @cached:  cached programming
> > + * @raw:     use _raw version of write_page
> >   */
> >  static int nand_write_page(struct mtd_info *mtd, struct nand_chip *chip,
> >                          const uint8_t *buf, int page, int cached, int raw)
> > -
>
> Hi Jesper,
> I'm still seeing a kernel-doc warning in include/linux/mtd/nand.h.
> Do you not see it also?
>
I see it, simply got distracted when doing the patch and forgot about it.


> Patch is here:
> http://marc.theaimsgroup.com/?l=linux-mm-commits&m=116189778426861&w=2
>
Looks good.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
