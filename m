Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287131AbRL2Eov>; Fri, 28 Dec 2001 23:44:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287132AbRL2Eol>; Fri, 28 Dec 2001 23:44:41 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:38161 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S287131AbRL2EoX>;
	Fri, 28 Dec 2001 23:44:23 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Mike Castle <dalgoda@ix.netcom.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: State of the new config & build system 
In-Reply-To: Your message of "Fri, 28 Dec 2001 20:21:39 -0800."
             <20011229042139.GC14067@thune.mrc-home.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 29 Dec 2001 15:44:10 +1100
Message-ID: <9467.1009601050@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Dec 2001 20:21:39 -0800, 
Mike Castle <dalgoda@ix.netcom.com> wrote:
>On Fri, Dec 28, 2001 at 10:58:03PM -0500, Legacy Fishtank wrote:
>> s/break/update dependencies/
>> 
>> I assumed this was blindingly obvious, but I guess not.
>
>To YOU and other kernel hackers, yes.
>
>But not to everyone.
>
>Plus, as I understand it, it will be faster to:
>
>apply a patch and rebuild with kbuild 2.5
>
>than to:
>
>apply a patch, make dep && make bzImage.
>
>Correct?

As long as the patch does not change an include file that is used a
lot, yes, a patch and make will be significantly faster using kbuild
2.5.

What Mr. Fishtank seems to overlook is that kbuild 2.5 is far more
flexible and accurate than 2.4, including features that lots of people
want, like separate source and object trees.  Now that the overall
kbuild design is correct, the core code can be rewritten for speed.
And that will be done a couple of weeks after kbuild 2.5 goes into the
kernel, then I expect kbuild 2.5 to be faster than kbuild 2.4 even on
full builds.

