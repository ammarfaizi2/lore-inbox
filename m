Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314502AbSDRXtU>; Thu, 18 Apr 2002 19:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314503AbSDRXtT>; Thu, 18 Apr 2002 19:49:19 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:49421 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S314502AbSDRXtS>; Thu, 18 Apr 2002 19:49:18 -0400
Message-ID: <3CBF5B67.E488A8E5@zip.com.au>
Date: Thu, 18 Apr 2002 16:48:55 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Mark Peloquin <peloquin@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Bio pool & scsi scatter gather pool usage
In-Reply-To: <OFCF00F1A4.2665039D-ON85256B9F.006B755C@pok.ibm.com> from "Mark Peloquin" at Apr 18, 2002 05:58:16 PM <E16yLS4-0005vN-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Perhaps, but calls are expensive. Repeated calls down stacked block
> > devices will add up. In only the most unusually cases will there
> 
> You don't need to repeatedly query. At bind time you can compute the
> limit for any device heirarchy and be done with it.
> 

S'pose so.  The ideal request size is variable, based
on the alignment.  So for exampe if the start block is
halfway into a stripe, the ideal BIO size is half a stripe.

But that's a pretty simple table to generate once-off,
as you say.

-
