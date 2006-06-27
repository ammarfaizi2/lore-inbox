Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932544AbWF0TSH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932544AbWF0TSH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 15:18:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932542AbWF0TSG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 15:18:06 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:63983 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932544AbWF0TSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 15:18:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U1Hir4v0KqnMSQRYQWzsqWs6i1iLyU//w2+2CiONFdFEHJpGPSb0nqbWd0kDVyzNGkU098A8QbSnMQRgfF7O/uY2OoIicI5wbJjWiujML4UjzHyIZFLmo13rZ67Z22hVbssvsu7pqKH7VMSjFoNnX1fHFQohZixlvdFZhmwyWMs=
Message-ID: <cda58cb80606271218j427f926duc997a9a5b1b7f3e4@mail.gmail.com>
Date: Tue, 27 Jun 2006 21:18:01 +0200
From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
To: "Dave Hansen" <haveblue@us.ibm.com>
Subject: Re: [PATCH 2/7] bootmem: mark link_bootmem() as part of the __init section
Cc: "Andrew Morton" <akpm@osdl.org>, "Mel Gorman" <mel@skynet.ie>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <1151428665.24103.2.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <449FDD02.2090307@innova-card.com>
	 <1151344691.10877.44.camel@localhost.localdomain>
	 <44A12A4F.8030204@innova-card.com>
	 <1151428665.24103.2.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/6/27, Dave Hansen <haveblue@us.ibm.com>:
> On Tue, 2006-06-27 at 14:53 +0200, Franck Bui-Huu wrote:
> > Signed-off-by: Franck Bui-Huu <vagabon.xyz@gmail.com>
> > ---
> >  mm/bootmem.c |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/mm/bootmem.c b/mm/bootmem.c
> > index d213fed..d0a34fe 100644
> > --- a/mm/bootmem.c
> > +++ b/mm/bootmem.c
> > @@ -56,7 +56,7 @@ unsigned long __init bootmem_bootmap_pag
> >  /*
> >   * link bdata in order
> >   */
> > -static void link_bootmem(bootmem_data_t *bdata)
> > +static void __init link_bootmem(bootmem_data_t *bdata)
> >  {
> >       bootmem_data_t *ent;
> >       if (list_empty(&bdata_list)) {
>
> Looks sane.  Just curious, did you do any wider audit in bootmem.c for
> more of these?
>

I checked that all functions in bootmem.c belong to the __init section.

-- 
               Franck
