Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261350AbULSXpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261350AbULSXpZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Dec 2004 18:45:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261353AbULSXpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Dec 2004 18:45:25 -0500
Received: from main.gmane.org ([80.91.229.2]:50142 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261350AbULSXpQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Dec 2004 18:45:16 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Joseph Seigh" <jseigh_02@xemaps.com>
Subject: Re: What does atomic_read actually do?
Date: Sun, 19 Dec 2004 18:50:54 -0500
Message-ID: <opsi94i4z0s29e3l@grunion>
References: <opsi7o5nqfs29e3l@grunion>  <1103394867.4127.18.camel@laptopd505.fenrus.org> <opsi7xcuizs29e3l@grunion>  <1103399680.4127.20.camel@laptopd505.fenrus.org> <opsi707edhs29e3l@grunion> <1103494866.6052.354.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.ne.client2.attbi.com
User-Agent: Opera M2/7.54 (Win32, build 3865)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Dec 2004 17:21:06 -0500, Robert Love <rml@novell.com> wrote:

> On Sat, 2004-12-18 at 15:43 -0500, Joseph Seigh wrote:
>
>> > it does so on *x86
>>
>> Is this documented for gcc anywhere?  Just because it does so doesn't
>> mean it's guaranteed.
>
> Listen to what Arjan is saying: It is not a compiler feature.  x86
> already guarantees that an aligned word-size read is atomic in the
> nothing-can-interleave sense.
>
I'm aware of that.  I'm not asking a question about x86 architecture.  I'm
asking what guarantees that the compiler will load the int using one MOV
instruction since there's nothing in the C standard that requires that,  
even
for volatile.   I think it's unlikely the compiler would use multiple loads
a byte at a time but it really requires a compiler person to  
authoritatively
make that statement.

It's a big problem getting support for threaded programming in C since the
C standard doesn't acknowlege threads.  For Posix threads, Posix had to  
come
up with a separate compliance certification for C compilers.  So when you  
use
posix pthreads, you have to use a posix compliant compiler to ensure your
program will work correctly.

It's the same issue here.  The atomic functions are another thread api.   
What's
the assurance that gcc supports this api correctly?   There was the  
possibility
since the C standard leaves it implementation dependent what constitutes
volatile access, that gcc did something special there.  But the gcc  
documentation
says this for volatile, "There is no guarantee that these reads and writes  
are atomic,
especially for objects larger than int."

http://gcc.gnu.org/onlinedocs/gcc-3.4.3/gcc/Volatiles.html#Volatiles

Joe Seigh

