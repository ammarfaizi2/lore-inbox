Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261790AbRESMRF>; Sat, 19 May 2001 08:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261793AbRESMQz>; Sat, 19 May 2001 08:16:55 -0400
Received: from khan.acc.umu.se ([130.239.18.139]:3469 "EHLO khan.acc.umu.se")
	by vger.kernel.org with ESMTP id <S261790AbRESMQu>;
	Sat, 19 May 2001 08:16:50 -0400
Date: Sat, 19 May 2001 14:16:27 +0200
From: David Weinehall <tao@acc.umu.se>
To: Anuradha Ratnaweera <anuradha@gnu.org>
Cc: Lorenzo Marcantonio <lorenzo.marcantonio@sinfopragma.it>,
        "H. Peter Anvin" <hpa@transmeta.com>, root@chaos.analogic.com,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.4 failure to compile
Message-ID: <20010519141626.C6110@khan.acc.umu.se>
In-Reply-To: <Pine.WNT.4.31.0105180827380.65-100000@pc209.sinfopragma.it> <Pine.LNX.4.21.0105181638000.251-100000@presario>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <Pine.LNX.4.21.0105181638000.251-100000@presario>; from anuradha@gnu.org on Fri, May 18, 2001 at 04:41:16PM +0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2001 at 04:41:16PM +0600, Anuradha Ratnaweera wrote:
> 
> On Fri, 18 May 2001, Lorenzo Marcantonio wrote:
> 
> > On Thu, 17 May 2001, H. Peter Anvin wrote:
> > 
> > > I think the header file you're talking about is the db1 header file,
> > > which has nothing to do with yacc -- it's the Berkeley libdb version 1,
> > > which is a pretty bad thing to require.
> > >
> > 
> > I've got it to compile (and apparently work) even con libdb3... which
> > has the compability header db_185.h (or something similar).
> > 
> > IIRC, libdb1 was bundled with libc till release 2.1.3. Since 2.2 they've
> > said 'get it at sleepycat...'.
> > 
> > BTW, there are ifdef inside the driver about which header to include
> > (db.h or db_185.h IIRC).
> > 
> > I still doesn't comprend what does it NEED FOR the libdb...
> 
> I don't do any module programming yet, but the lkmpg lists "Using standard
> libraries" under "Common Pitfalls". Is anything unusual going on here?

Yup. The code in question is not a module, but rather a userspace-program
that generates microcode for the SCSI-adapter(s) in question. As such,
using standard libraries is fully ok. The debate is whether libdb1
is to be considered common enough.


Regards: David Weinehall
  _                                                                 _
 // David Weinehall <tao@acc.umu.se> /> Northern lights wander      \\
//  Project MCA Linux hacker        //  Dance across the winter sky //
\>  http://www.acc.umu.se/~tao/    </   Full colour fire           </
