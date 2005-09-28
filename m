Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbVI1Nde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVI1Nde (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 09:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750962AbVI1Nde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 09:33:34 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:48289 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1750960AbVI1Ndd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 09:33:33 -0400
Subject: Re: AIO Support and related package information??
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: vikas gupta <vikas_gupta51013@yahoo.co.in>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <20050928125815.74025.qmail@web8405.mail.in.yahoo.com>
References: <20050928125815.74025.qmail@web8405.mail.in.yahoo.com>
Date: Wed, 28 Sep 2005 15:35:25 +0200
Message-Id: <1127914525.2069.46.camel@frecb000686>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/09/2005 15:46:52,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 28/09/2005 15:46:53,
	Serialize complete at 28/09/2005 15:46:53
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-09-28 at 13:58 +0100, vikas gupta wrote:
> hi Sebastien,
> 
> Thanks for your Support 
> well i am able to build for arm platform by removing
> all the exit statments from configure script but while
> executing on arm board ,i am getting this result log
> for libposix-0.6/check :
> 
> aio_cancel: cancel error : 1 (Operation not permitted)
> aio_cancel_fd: cancel returned AIO_NOTCANCELED
> aio_fsync: fsync error 1 (Operation not permitted)
> aio_read_one_sig: aio_read error: Invalid argument
> aio_read_one_thread: aio_read error: Invalid argument
> aio_read_one_thread_id: aio_read error: Invalid
> argument
> aio_suspend: Cannot create testfile: Invalid argument
> aio_suspend_timeout: Cannot create testfile: Invalid
> argument
> aio_write_one_sig: aio_write error: Invalid argument
> aio_write_thread: aio_write error: Invalid argument
> aio_write_one_thread_id: aio_write error: Invalid
> argument
> lio_listio_wait: Cannot open testfile: Invalid
> argument
> lio_listio_nowait: Cannot open testfile: Invalid
> argument
> 
> only two test cases ./aio_read_one and ./aio_write_one
> is not giving 
> any
> error
> 
> Is this justified
> Do you think it is correct ,This is with bare
> kernel2.6.11 and libposix-0.6 package 

  This is perfectly normal as a vanilla kernel only have
support for aio_read and aio_write without event notification
so only aio_read_one and aio_write_one will pass



> 2)
> 
> > ./configure --disable-default-maxevents
> > --disable-aio-signal
> > --disable-lio-signal --disable-lio-wait
> > --disable-cancel-fd
> > --disable-buffered-aio
> > 
> >   that way, the configure script will not try to
> > autodetect
> > kernel features.
> > 
> >   The configure options available may be found with
> > 
> >     configure --help
> > 
> >   aio_read and aio_write with no event notification
> > should work
> > provided you implemented the ARM syscall wrappers.
> 
> I tried this approach but i am getting these errors 
> 
> Errors :
> 
> checking for signal support on AIO completion...
> configure: error: 
> cannot
> run test program while cross compiling
> See `config.log' for more details.
> checking for signal support on LIO completion...
> configure: error: 
> cannot
> run test program while cross compiling
> 
> Can this be Resolved 

  Strange, if you gave the --disable-aio-signal and
--disable-lio-signal arguments, configure should not even
try to check those features. Send me your resulting
config.log.

  Sébastien.

-- 
------------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
  
------------------------------------------------------

