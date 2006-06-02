Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbWFBHyE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbWFBHyE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 03:54:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbWFBHyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 03:54:04 -0400
Received: from wr-out-0506.google.com ([64.233.184.230]:30814 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751298AbWFBHyB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 03:54:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cEKykoYtci+QLLb/2D06I5ZYRjj19fCGaeKt+NXqeB0bGzsPjKMIylA1Vc5CFdtGpR+bQf7oJ673Cn+zqcgeI2rSTcDsA8Ku+vCFVNN6Rinv9oePfdBFIxWJmhsRO36pEwZGiFi7bM91Jn3cHryFb4vyk7jAVBv7fvdPl5XJjwk=
Message-ID: <9a8748490606020053m55e341a1v482c904ee7e423cf@mail.gmail.com>
Date: Fri, 2 Jun 2006 09:53:59 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Nick Piggin" <nickpiggin@yahoo.com.au>
Subject: Re: Page Allocation Failure, Why?? Bug in kernel??
Cc: "Abu M. Muttalib" <abum@aftek.com>, "Martin J. Bligh" <mbligh@mbligh.org>,
       "Paulo Marques" <pmarques@grupopie.com>, linux-kernel@vger.kernel.org
In-Reply-To: <447FEC1B.80205@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BKEKJNIHLJDCFGDBOHGMEEJNCNAA.abum@aftek.com>
	 <447FEC1B.80205@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/06/06, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Abu M. Muttalib wrote:
> > Hi,
> >
> > I repeat my question, the required no of pages are available, as shown in
> > the dump produced by kernel, the request is not fulfilled. Its as follows:
> >
> > DMA: 106*4kB 11*8kB 5*16kB 3*32kB 2*64kB 1*128kB 0*256kB 0*512kB 0*1024kB =
> > 944kB
> >
> > Why this is so??
>
> Because some are kept in "emergency pools" for allocators that cannot
> sleep trying to free up memory.
>
> Teach the sound driver to use smaller buffers or just insert it at boot
> and leave it inserted. Why are you removing it then reinserting it?
>

Or, if the driver just need 32 pages that *appear* to be contiguous
without actually having to be physically contiguous, then allocate the
space with vmalloc(). Not always possible ofcourse, but if it is for
Abu's use, then perhaps that could be a solution.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
