Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317489AbSIBGlq>; Mon, 2 Sep 2002 02:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSIBGlq>; Mon, 2 Sep 2002 02:41:46 -0400
Received: from dial-ctb0142.webone.com.au ([210.9.241.42]:41477 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id <S317489AbSIBGlp>;
	Mon, 2 Sep 2002 02:41:45 -0400
Message-ID: <002c01c251f8$84bc2fe0$0a00a8c0@W2K>
From: "Nick Piggin" <piggin@cyberone.com.au>
To: "Neil Brown" <neilb@cse.unsw.edu.au>,
       "William Lee Irwin III" <wli@holomorphy.com>
Cc: "Robert Love" <rml@tech9.net>, "Rusty Russell" <rusty@rustcorp.com.au>,
       <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>,
       <akpm@zip.com.au>
References: <20020902003318.7CB682C092@lists.samba.org><1030945918.939.3143.camel@phantasy><20020902060257.GO888@holomorphy.com> <15731.1019.581339.120099@notabene.cse.unsw.edu.au>
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
Date: Mon, 2 Sep 2002 06:45:23 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

For the code in question, a list entry _is_ a list is it not? By how big a
stretch of the
imagination is each entry a list in a different rotation?

----- Original Message -----
From: "Neil Brown" <neilb@cse.unsw.edu.au>
To: "William Lee Irwin III" <wli@holomorphy.com>
Cc: "Robert Love" <rml@tech9.net>; "Rusty Russell" <rusty@rustcorp.com.au>;
<torvalds@transmeta.com>; <linux-kernel@vger.kernel.org>; <akpm@zip.com.au>
Sent: Monday, September 02, 2002 4:23 PM
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.


> On Sunday September 1, wli@holomorphy.com wrote:
> > On Mon, 2002-09-02 at 01:23, Rusty Russell wrote:
> > >> This week, it spread to SCTP.
> > >> "struct list_head" isn't a great name, but having two names for
> > >> everything is yet another bar to reading kernel source.
> >
> > On Mon, Sep 02, 2002 at 01:51:54AM -0400, Robert Love wrote:
> > > I am all for your cleanup here, but two nits:
> > > Why not rename list_head while at it?  I would vote for just "struct
> > > list" ... the name is long, and I like my lines to fit 80 columns.
> >
> > Seconded. Throw the whole frog in the blender, please, not just
> > half.
>
> The struct in question is a handle on an element of a list, or the
> head of a list, but it is not a list itself.  A list is a number of
> stuctures each of which contain (inherit from?)  the particular
> structure.  So calling it "struct list" would be wrong, because it
> isn't a list, only part of one.
>
> Maybe "struct list_element" or "struct list_entry" would be OK.  But
> I'm happy with "struct list_head", because the thing is, at least
> sometimes, the head of a list.
>
> NeilBrown
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

