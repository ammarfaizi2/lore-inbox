Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932213AbVJCKzT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932213AbVJCKzT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 06:55:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932219AbVJCKzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 06:55:19 -0400
Received: from web8408.mail.in.yahoo.com ([202.43.219.156]:48490 "HELO
	web8408.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S932213AbVJCKzS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 06:55:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=njCPk1PSJS02STXtfyhZpYytUYh0SFpZiSIYj885y+Gjfh82xWCpmz+NHZFDH460RaI9mSy+xcbDCj0dE7nUiXxWzJ5d12TIYW1N/nNq6cAxM6bjgmQguTHI6XrWpUX0sZQgXTIdNbgZW5iebELRfa8ye+sb1Y76kT8lmJNsn08=  ;
Message-ID: <20051003105511.90508.qmail@web8408.mail.in.yahoo.com>
Date: Mon, 3 Oct 2005 11:55:11 +0100 (BST)
From: vikas gupta <vikas_gupta51013@yahoo.co.in>
Subject: Re: 2.6.13-rc6-xx-all.diff is not working for 2.6.13 arm kernel
To: Russell King <rmk+lkml@arm.linux.org.uk>,
       Denis Vlasenko <vda@ilport.com.ua>
Cc: bcrl@kvack.org, linux-aio@kvack.org, linux-kernel@vger.kernel.org
In-Reply-To: <20051003100731.GB16717@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

--- Russell King <rmk+lkml@arm.linux.org.uk> wrote:

> On Mon, Oct 03, 2005 at 12:27:34PM +0300, Denis
> Vlasenko wrote:
> > On Monday 03 October 2005 12:22, vikas gupta
> wrote:
> > > hi ben ,
> > > 
> > > I tried to apply 2.6.13-rc6-B0/B1-all.diff to
> > > linux-2.6.13 kernel with arm support patches .
> It's
> > > getting applied cleanly...
> > > but while building the kernel i am getting some
> build
> > > errors ... 
> > > i traced the problem and get that this error are
> > > coming because of some machine specific files.
> > > 1)arch/i386/kernel/semaphore.c
> > > 2)include/asm-i386/seamphore.h
> > > 
> > > So can you please tell me that whather any patch
> is
> > > available, in order to support these
> implementation on
> > > arm platform.
> > 
> > How nice that you did not show the actual error
> message
> > and did not show your .config
> 
> That's usual in the embedded world - it's a way that
> embedded folk seem
> to write their bug reports to provoke a "response" 
> (the content of the
> response doesn't seem to matter, just as long as
> there is one.)
> 
> However, one also has to wonder - "2.6.13 kernel
> with arm support patches"
> "arch/i386/kernel/semaphore.c".  Why have "arm"
> patches been applied (and
> what were they) and why i386 is being built.

Sorry for my mistake..
Arm kernel build Error LOG:
.....
CC      mm/filemap.o
mm/filemap.c: In function `generic_file_aio_writev':
mm/filemap.c:2212: warning: implicit declaration of
function `aio_down'
mm/filemap.c:2216: warning: implicit declaration of
function `aio_up'
....
fs/pipe.c: In function `pipe_aio_wait':
fs/pipe.c:105: warning: implicit declaration of
function `aio_up'
fs/pipe.c: In function `pipe_aio_read':
fs/pipe.c:206: warning: implicit declaration of
function `aio_down'

.....
mm/built-in.o(.text+0x3e34): In function
`generic_file_aio_writev':
: undefined reference to `aio_down'
mm/built-in.o(.text+0x3e60): In function
`generic_file_aio_writev':
: undefined reference to `aio_up'
fs/built-in.o(.text+0x10258): In function
`pipe_aio_wait':
: undefined reference to `aio_up'
fs/built-in.o(.text+0x103a0): In function
`pipe_aio_read':
: undefined reference to `aio_down'
fs/built-in.o(.text+0x10648): In function
`pipe_aio_read':
: undefined reference to `aio_up'
fs/built-in.o(.text+0x10758): In function `$a':
: undefined reference to `aio_down'
fs/built-in.o(.text+0x10c60): In function `$a':
: undefined reference to `aio_up'
make: *** [.tmp_vmlinux1] Error 1


These functions are defined for i386 as well as x86_64

but for arm platform as above mentioned files (those i
mentioned in previos mails )are not present these are
giving errors ...
So i wanted to ask whether any patch is available for
it or not




		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
