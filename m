Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130115AbRB1Ic7>; Wed, 28 Feb 2001 03:32:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130111AbRB1Icu>; Wed, 28 Feb 2001 03:32:50 -0500
Received: from t2.redhat.com ([199.183.24.243]:55796 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S130105AbRB1Ich>; Wed, 28 Feb 2001 03:32:37 -0500
To: lkthomas@hkicable.com
Cc: Dan Kegel <dank@alumni.caltech.edu>, linux-kernel@vger.kernel.org
Subject: Re: Wine + kernel ?? How to do that? 
In-Reply-To: Your message of "Wed, 28 Feb 2001 02:54:45 +0800."
             <3A9BF7F5.E3AE76AB@hkicable.com> 
Date: Wed, 28 Feb 2001 08:32:25 +0000
Message-ID: <6254.983349145@warthog.cambridge.redhat.com>
From: David Howells <dhowells@cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lkthomas@hkicable.com wrote:
> hey, I hear that wine ( windows emulator ) can port into kernel and make 
> it running faster, How can I do it? 
> or anyone can make a patch to add wine code into kernel? 
> waiting for answer, Thanks 

I've been writing one to provide all the Windows kernel objects in Linux
kernel space (the speed up appears as though it should be impressive). It is,
however, not entirely complete yet. You can grab a copy by CVS from the wine
repository:

	export CVSROOT=:pserver:cvs@cvs.winehq.com:/home/wine
	cvs login
	  (the password is cvs)
	cvs -z3 checkout kernel-win32

Or you can browse it:

	http://cvs.winehq.com/cvsweb/kernel-win32/

The numbers are looking good: the system call latency appears to be about half
that of Win2000 on the same box! (however, use this number with caution).

David
