Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285907AbSADXbi>; Fri, 4 Jan 2002 18:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285850AbSADXb2>; Fri, 4 Jan 2002 18:31:28 -0500
Received: from dsl-213-023-043-154.arcor-ip.net ([213.23.43.154]:4616 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S285878AbSADXbQ>;
	Fri, 4 Jan 2002 18:31:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Andreas Dilger <adilger@turbolabs.com>, Andries.Brouwer@cwi.nl
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
Date: Sat, 5 Jan 2002 00:33:45 +0100
X-Mailer: KMail [version 1.3.2]
Cc: acme@conectiva.com.br, ion@cs.columbia.edu, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Thomas Graichen <tgr@spoiled.org>
In-Reply-To: <UTC200201041516.PAA224847.aeb@cwi.nl> <20020104152056.Z12868@lynx.no>
In-Reply-To: <20020104152056.Z12868@lynx.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16MdqR-0001EQ-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 4, 2002 11:20 pm, Andreas Dilger wrote:
> On Jan 04, 2002  15:16 +0000, Andries.Brouwer@cwi.nl wrote:
> >     sizeof (foo): 1611, sizeof(foo): 19364 => -bs should be removed
> >
> >     int
> >     foo(int x): 11408, int foo(int x): 57275 => -psl should be removed
> > 
> > I do not think good style is best defined by majority vote.
> 
> Certainly not.  However, the Lindent style I'm trying to achieve is that
> dictated by Linus.  However, CodingStyle doesn't give all of the details
> of how code should be formatted, so I have to look at the code to see
> what is actually there.
> 
> >     (void *) foo: 11274, (void *)foo: 17062 => -ncs should be added
> > 
> > Read old kernel sources.
> > 
> >         de = (struct minix_dir_entry *) (offset + bh->b_data);
> > 
> > 	:"S" ((long) name),"D" ((long) buffer),"c" (len)
> > 
> > 	if (32 != sizeof (struct minix_inode))
> 
> Well, that's what I was trying to do when I found out that lksr.org
> (hosted by innominate.de) was not available.  It seems the -ncs
> change is incorrect then (although my preference is to add it - there
> doesn't seem to me to be any benefit of having the extra space).

Thomas Graichen told me that lksr.org will be back up 'soon'.  Innominate.org 
is back up, run by Gerrit Pape, one of a group of Berliners who call 
themselves 'exnominate' (that would include me).  In fact, innominate itself 
is back, but that's a whole nuther story.

p.s., if Andries is right - and he probably is - then it looks like Linus's 
habitual style is 'space after cast' and 'space after sizeof'.  We could 
always ask.

If we put enough work into lindent, maybe we'll come up with a Linusbot?

--
Daniel
