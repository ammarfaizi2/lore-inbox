Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932127AbVIZNpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbVIZNpE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 09:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbVIZNpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 09:45:04 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:1422 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP id S932127AbVIZNpB convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 09:45:01 -0400
Subject: Re: AIO Support and related package information??
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: vikas gupta <vikas_gupta51013@yahoo.co.in>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <20050926091302.10847.qmail@web8403.mail.in.yahoo.com>
References: <20050926091302.10847.qmail@web8403.mail.in.yahoo.com>
Date: Mon, 26 Sep 2005 15:45:12 +0200
Message-Id: <1127742313.2103.27.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 26/09/2005 15:56:37,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 26/09/2005 15:58:18,
	Serialize complete at 26/09/2005 15:58:18
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-26 at 10:13 +0100, vikas gupta wrote:
> hi sebastien,
> 
> > 
> >>   Have a look at:
> >>
> http://www.bullopensource.org/posix/Bench/sysbench->oltp/sysbench.html
> >> for benchmarks using Sysbench and MySQL.
> 
> I think this link is broken as it is not working ...
> Can you please check it ....

  It's working but your mail client may have broken down the url.
Start at http://www.bullopensource.org/posix/ and follow the
Sysbench - oltp link under Benchmark results.

> 
> >> > 2.1) aio_read/aio_write  is supported but what
> >> > limitation are there
> >> 
> >>   Supported but without notification (SIGEV_NONE
> >> only).
> 
> Can you please tell whether kernel behaves
> asynchronously for read operation without O_DIRECT
> MACRO's ???

  Without any of the patches you need to use O_DIRECT
and aligned buffers, size and offset.

  Buffered AIO is implemented by Suparna's patches.

> 
> > > 4) Is there any test program that can measure
> > > efficiency for both glibc and libposix
> > implementation
> > 
> >   I personally use Sysbench and have compiled 3
> > MySQL servers,
> > one with librt AIO, one with libposix-aio and one
> > with MySQL
> > native simulated AIO.
> > 
> >   You may also try iozone.
> 
> Can you please tell which one is better among three
> that you have tested 

  It depends on what you want to benchmark. Typically, Sysbench
in oltp mode mimics database use.

> 
> 4) Is there any simple procedure to test the above
> mentioned library packages ???

  For POSIX conformance, have a look at the Open POSIX
Test Suite at http://posixtest.sourceforge.net/

  Sébastien.
-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

