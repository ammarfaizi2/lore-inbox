Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261316AbSJCOCT>; Thu, 3 Oct 2002 10:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263266AbSJCOCT>; Thu, 3 Oct 2002 10:02:19 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:23984 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261316AbSJCOCR>;
	Thu, 3 Oct 2002 10:02:17 -0400
Importance: Normal
Sensitivity: 
Subject: Re: [Evms-devel] Re: [PATCH] EVMS core 4/4: evms_biosplit.h
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       evms-devel@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OF80394318.42D7FE1A-ON85256C47.004D1459@pok.ibm.com>
From: "Mark Peloquin" <peloquin@us.ibm.com>
Date: Thu, 3 Oct 2002 09:10:03 -0500
X-MIMETrack: Serialize by Router on D01ML072/01/M/IBM(Release 5.0.11  |July 29, 2002) at
 10/03/2002 10:05:17 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 10/03/02 at 8:57 AM, Alan Cox wrote:
> > +static void
> > +bio_split_setup(char * split_name, char * bio_name)
> > +{
> > + /* initialize MY bio split record pool */
> > + my_bio_split_slab = kmem_cache_create(split_name,
> > +                               sizeof
> > +                               (struct bio_split_cb),
> > +                               0, SLAB_HWCACHE_ALIGN,
> > +                                                NULL, NULL);
> > + if (!my_bio_split_slab) {
> > +       panic("unable to create EVMS Bio Split cache.");

> If IBM are going to be doing telco grade stuff you could start now by
> failing politely in this case 8)

Your absolutely right! The appropriate changes will be made
immediately. Also, please bear in mind that this bio
splitting code is just temporary until the community comes
up with an acceptable generic solution.

Mark





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Evms-devel mailing list
Evms-devel@lists.sourceforge.net
To subscribe/unsubscribe, please visit:
 https://lists.sourceforge.net/lists/listinfo/evms-devel




