Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131266AbRAJI1O>; Wed, 10 Jan 2001 03:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132360AbRAJI1E>; Wed, 10 Jan 2001 03:27:04 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:20718 "EHLO
	lappi.waldorf-gmbh.de") by vger.kernel.org with ESMTP
	id <S131266AbRAJI0y>; Wed, 10 Jan 2001 03:26:54 -0500
Date: Wed, 10 Jan 2001 05:48:11 -0200
From: Ralf Baechle <ralf@conectiva.com.br>
To: Pauline Middelink <middelin@polyware.nl>, linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@conectiva.com.br>, linux@advansys.com,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] advansys.c: include missing restore_flags, etc
Message-ID: <20010110054811.A19220@bacchus.dhis.org>
In-Reply-To: <20010108201103.E17087@conectiva.com.br> <20010108202533.F17087@conectiva.com.br> <20010108203002.H17087@conectiva.com.br> <20010109001443.A20786@conectiva.com.br> <20010109083007.A24914@polyware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010109083007.A24914@polyware.nl>; from middelink@polyware.nl on Tue, Jan 09, 2001 at 08:30:07AM +0100
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 08:30:07AM +0100, Pauline Middelink wrote:

> > -STATIC int
> > +STATIC unsigned long
> >  DvcEnterCritical(void)
> >  {
> > -    int    flags;
> > +    unsigned long flags;
> >  
> >      save_flags(flags);
> >      cli();
> > @@ -9965,7 +9972,7 @@
> >  }
> 
> Err, according tho wise ppl on this list, this does not work on
> MIPSes. The flags thing must stay in the same stackframe.

Nope, that's on Sparc.

> >  STATIC void
> > -DvcLeaveCritical(int flags)
> > +DvcLeaveCritical(unsigned long flags)
> >  {
> >      restore_flags(flags);
> >  }
> 
> Item.

My Latin teach says it's ``idem''.

  Ralf

--
"Embrace, Enhance, Eliminate" - it worked for the pope, it'll work for Bill.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
