Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290622AbSAYKIZ>; Fri, 25 Jan 2002 05:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290631AbSAYKIL>; Fri, 25 Jan 2002 05:08:11 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:47120 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S290622AbSAYKHy>; Fri, 25 Jan 2002 05:07:54 -0500
Message-ID: <3C513C6E.101F0689@aitel.hist.no>
Date: Fri, 25 Jan 2002 12:07:26 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.2-dj4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: timothy.covell@ashavan.org, linux-kernel@vger.kernel.org
Subject: Re: RFC: booleans and the kernel
In-Reply-To: <Pine.LNX.4.44.0201241433110.2839-100000@waste.org> <200201242123.g0OLNAL06617@home.ashavan.org.>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Covell wrote:
> 
> On Thursday 24 January 2002 14:39, Oliver Xymoron wrote:
> >
> > The compiler _will_ turn if(a==0) into a test of a with itself rather than
> > a comparison against a constant. Since PDP days, no doubt.
> 
> I thought that the whole point of booleans was to stop silly errors
> like
> 
> if ( x = 1 )
> {
>         printf ("\nX is true\n");
> }
> else
> {
>         # we never get here...
> }

Booleans won't help that.  If you _want_ to fix that, change
the assignment operator so it don't look like a comparison.
Perhaps x <- 45; or something.  Won't happen to C of course.

Oh, and writing if (a=b) is valid way of testing for a non-zero
b while also assigning to a.  I write code that way when I
need such a set of operation.  Short, elegant, and no, it isn't
hard to read at all.

Helge Hafting
