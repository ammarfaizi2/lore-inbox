Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263216AbVGAFCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263216AbVGAFCX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 01:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263219AbVGAFCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 01:02:23 -0400
Received: from web8409.mail.in.yahoo.com ([202.43.219.157]:57252 "HELO
	web8409.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S263216AbVGAFCS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 01:02:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=Q4SEqeh1OM+DzQFTJKFrMexC3eUPxGBWUVxHgcGrhPkR8gWNt7ic4gcqmW5GETw5F+RKgb5Q8xv1qaL/ajRTrnTOt/dWVN9ew8ku5xBg8Y30bhIGcwcOCbsbTrBbp75F1n1Zpo6zb9sez5kgAeU9YdwyoiyaV+brpmD9Hh1t4Ec=  ;
Message-ID: <20050701050211.13974.qmail@web8409.mail.in.yahoo.com>
Date: Fri, 1 Jul 2005 06:02:11 +0100 (BST)
From: KV Pavuram <kvpavuram@yahoo.co.in>
Subject: Re: Pthreadid, pid
To: Andrew Burgess <aab@cichlid.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200506302001.j5UK1L7w008821@cichlid.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you Andrew. It worked.

Pav. 


--- Andrew Burgess <aab@cichlid.com> wrote:

> >When i run a multi-threaded program from gdb, gdb
> >shows "New Thread XXXXXXXX (LWP LLLL)" for each new
> >thread created by the application.
> 
> >However, when I run ps -aelfm, the output shows
> each
> >thread of this application but with a different
> PID.
> 
> >And, getpid () in each thread inside the
> application
> >always retreives the same PID.
> 
> >What is the relation between LWP is given by GDB,
> PID
> >shown by ps call and the PID returned by getpid ().
> 
> >Is there any system call to obtain one from the
> >other??
> 
> see gettid(2)
> 
> you need to include the macro call
> _syscall0(pid_t,gettid)
> in your program as gettid isn't in glibc
> 
> 



		
_______________________________________________________
Too much spam in your inbox? Yahoo! Mail gives you the best spam protection for FREE! http://in.mail.yahoo.com
