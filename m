Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751271AbVI1M5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751271AbVI1M5a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 08:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751275AbVI1M5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 08:57:30 -0400
Received: from web8403.mail.in.yahoo.com ([202.43.219.151]:15033 "HELO
	web8403.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1751271AbVI1M53 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 08:57:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=0VN5IIE33jUBmrlw/ZVs4F5tZX2+sUIcHmNLq8O1nZLLWLw3eeSmiH+j1G9O9QZKrF38bQkGFNxyjE0EFJvH54EYnQPDcEAn9P2ityk1Dh9zRbXxtftHppNG/NRQYG/w4Y4A5EqmWL97iI0r8iTJsavS91aDk8/J+4VRfpEUaz0=  ;
Message-ID: <20050928125726.66983.qmail@web8403.mail.in.yahoo.com>
Date: Wed, 28 Sep 2005 13:57:26 +0100 (BST)
From: vikas gupta <vikas_gupta51013@yahoo.co.in>
Subject: Re: AIO Support and related package information??
To: =?iso-8859-1?q?S=E9bastien=20Dugu=E9?= <sebastien.dugue@bull.net>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org
In-Reply-To: <1127892324.2103.39.camel@frecb000686>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi Sebastien,

Thanks for your Support 
well i am able to build for arm platform by removing
all the exit statments from configure script but while
executing on arm board ,i am getting this result log
for libposix-0.6/check :

aio_cancel: cancel error : 1 (Operation not permitted)
aio_cancel_fd: cancel returned AIO_NOTCANCELED
aio_fsync: fsync error 1 (Operation not permitted)
aio_read_one_sig: aio_read error: Invalid argument
aio_read_one_thread: aio_read error: Invalid argument
aio_read_one_thread_id: aio_read error: Invalid
argument
aio_suspend: Cannot create testfile: Invalid argument
aio_suspend_timeout: Cannot create testfile: Invalid
argument
aio_write_one_sig: aio_write error: Invalid argument
aio_write_thread: aio_write error: Invalid argument
aio_write_one_thread_id: aio_write error: Invalid
argument
lio_listio_wait: Cannot open testfile: Invalid
argument
lio_listio_nowait: Cannot open testfile: Invalid
argument

only two test cases ./aio_read_one and ./aio_write_one
is not giving 
any
error

Is this justified
Do you think it is correct ,This is with bare
kernel2.6.11 and libposix-0.6 package 
2)

> ./configure --disable-default-maxevents
> --disable-aio-signal
> --disable-lio-signal --disable-lio-wait
> --disable-cancel-fd
> --disable-buffered-aio
> 
>   that way, the configure script will not try to
> autodetect
> kernel features.
> 
>   The configure options available may be found with
> 
>     configure --help
> 
>   aio_read and aio_write with no event notification
> should work
> provided you implemented the ARM syscall wrappers.

I tried this approach but i am getting these errors 

Errors :

checking for signal support on AIO completion...
configure: error: 
cannot
run test program while cross compiling
See `config.log' for more details.
checking for signal support on LIO completion...
configure: error: 
cannot
run test program while cross compiling

Can this be Resolved 


Thanks in advance 
Vikas





		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
