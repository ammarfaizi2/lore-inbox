Return-Path: <linux-kernel-owner+w=401wt.eu-S1030505AbXAHTW1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030505AbXAHTW1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 14:22:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbXAHTW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 14:22:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:51223 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030505AbXAHTW0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 14:22:26 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:to:cc:subject:message-id:mail-followup-to:references:mime-version:content-type:content-disposition:in-reply-to:user-agent:from;
        b=GIoTAIjblosmc9VKLNgYscpFBjh6XIyzYM4X3KGYHq8TxWHwxVXLRsTw6c+ueOi7uZN6elBksfXztiCz/dDQAkSatfPRb/a5w9Gv9v65DYksp8tx5I0Vj3qDz+P2PD734DNcIrPQ9JxcNxqGEm698RMCAuMNdIu8wbpPyh2K+rA=
Date: Mon, 8 Jan 2007 21:21:52 +0200
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH UPDATED 2.6.20-rc3] Remove all the unneeded k[mzc]alloc casts
Message-ID: <20070108192152.GA3881@Ahmed>
Mail-Followup-To: Rolf Eike Beer <eike-kernel@sf-tec.de>,
	linux-kernel@vger.kernel.org
References: <20070105102623.GB382@Ahmed> <200701081310.46547.eike-kernel@sf-tec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701081310.46547.eike-kernel@sf-tec.de>
User-Agent: Mutt/1.5.11
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 01:10:19PM +0100, Rolf Eike Beer wrote:
> Ahmed S. Darwish wrote:
> > Hi all,
> > This is a patch to remove the unneeded k[mzc]alloc casts in the whole
> >
> > Signed-off-by: Ahmed Darwish
> >
> > diff --git a/arch/cris/arch-v32/mm/intmem.c
> > b/arch/cris/arch-v32/mm/intmem.c index 41ee7f7..acb4e21 100644
> > --- a/arch/cris/arch-v32/mm/intmem.c
> > +++ b/arch/cris/arch-v32/mm/intmem.c
> > @@ -27,8 +27,8 @@ static void crisv32_intmem_init(void)
> >  {
> >  	static int initiated = 0;
> >  	if (!initiated) {
> > -		struct intmem_allocation* alloc =
> > -		  (struct intmem_allocation*)kmalloc(sizeof *alloc, GFP_KERNEL);
> > +		struct intmem_allocation* alloc = kmalloc(sizeof *alloc,
> > +							  GFP_KERNEL);
> sizeof(*alloc) (see Documentation/CodingStyle)
> 
> There are some more of this kind.
> 

I had to do so since the whole file already uses a different coding style
than the one found in CodingStyle (uses type* foo, ..).
About the sizeof issue it seems every one here have his own opinion (readability
vs. reliability).

Anyway I've splitted the patch and resent them to lkml with CCing the 
appropriate maintainers since I was told that no one would accept this
big patch.

Regards
-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
