Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290631AbSAYKKI>; Fri, 25 Jan 2002 05:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290632AbSAYKJ4>; Fri, 25 Jan 2002 05:09:56 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:48912 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S290631AbSAYKJj>; Fri, 25 Jan 2002 05:09:39 -0500
Message-ID: <3C513CD8.B75B5C42@aitel.hist.no>
Date: Fri, 25 Jan 2002 12:09:12 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.2-dj4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> Oliver Xymoron wrote:
> > On Thu, 24 Jan 2002, Jeff Garzik wrote:
> > > Where variables are truly boolean use of a bool type makes the
> > > intentions of the code more clear.  And it also gives the compiler a
> > > slightly better chance to optimize code [I suspect].
> >
> > Unlikely. The compiler can already figure this sort of thing out from
> > context.
> 
> X, true, and false are of type int.
> If one tests X==false and then later on tests X==true, how does the
> compiler know the entire domain has been tested?  With a boolean, it

Why would anyone want to write   if (X==false) or if (X==true) ?
It is the "beginner's mistake" way of writing code.  Then people learn,
and write if (X) or if (!X).  Comparing to true/false is silly.
Nobody writes  if ( (a==b) == true) so why do it in the simpler cases?

> would.  Or a switch statement... if both true and false are covered,
A switch statement on a boolean value is stupid.  Use if - there
is only two cases.

Helge Hafting
