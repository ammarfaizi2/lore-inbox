Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262144AbVFUPyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262144AbVFUPyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 11:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVFUPyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 11:54:07 -0400
Received: from web8403.mail.in.yahoo.com ([202.43.219.151]:5018 "HELO
	web8403.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S262151AbVFUPuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 11:50:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=kAm/vWO+CVkwd4LcmB4hRRJZJNb2dUF6i/fWhb9npK5aGABhQ5Mo+EkOhjIYIIaELuRuVjrQIi00zj8++Z+f+1bs5NXek38sKi2N0brtruhwNmsQlyH3MSIIMPDqhPGebOoYcSsLcif8/dqmXhLQxezIo0qP3Zsw5ucbIiaCjk0=  ;
Message-ID: <20050621155041.44574.qmail@web8403.mail.in.yahoo.com>
Date: Tue, 21 Jun 2005 16:50:40 +0100 (BST)
From: KV Pavuram <kvpavuram@yahoo.co.in>
Subject: Re: 0xffffe002 in ??
To: linux-os@analogic.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0506211132140.17269@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

What about the webpage

https://bugzilla.redhat.com/bugzilla/long_list.cgi?buglist=104763

I am a kernel newbie, so I couldnt catch what is being
explained in the page though. But i do have
pthread_cond_wait in my code that are called too
often.

Regards,
Pav.

--- "Richard B. Johnson" <linux-os@analogic.com>
wrote:

> On Tue, 21 Jun 2005, KV Pavuram wrote:
> 
> > I am running a multithreaded application on Linux
> 2.4
> > kernel (RedHat Linux 9).
> >
> > At some point the program receives a seg. fault
> and if
> > i check info threads, using gdb for debug, almost
> all
> > the threads are at "0xffffe002 in ??"
> >
> 
> If a number of threads arrive at the same bad
> address you
> should look for some common code that calls through
> a function pointer. If you don't have any calls
> through
> pointers, then you may have something corrupting the
> stack
> so that the return address of a called function gets
> corrupted. For instance, if the value 0x02e0 was
> written
> beyond array limits in local (stack) data, then when
> that
> function returned it could actually end up
> 'returning'
> to the bad address you discovered.
> 
> Although the kernel provided the seg-fault
> mechanism, this
> is not a kernel problem. This is a user-code
> problem.
> 
> > When I switch to each of these tasks, and try x/i
> for
> > 0xffffe002, cannot access address.
> >
> > What could be the problem?
> >
> > Please help.
> >
> > Regards,
> > Pav.
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.12 on an i686 machine
> (5537.79 BogoMips).
>   Notice : All mail here is now cached for review by
> Dictator Bush.
>                   98.36% of all statistics are
> fiction.
> 



	

	
		
__________________________________________________________
Free antispam, antivirus and 1GB to save all your messages
Only in Yahoo! Mail: http://in.mail.yahoo.com
