Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292666AbSDIOxE>; Tue, 9 Apr 2002 10:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292730AbSDIOxD>; Tue, 9 Apr 2002 10:53:03 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:9107 "EHLO mail3.aracnet.com")
	by vger.kernel.org with ESMTP id <S292666AbSDIOxD>;
	Tue, 9 Apr 2002 10:53:03 -0400
Date: Tue, 09 Apr 2002 07:50:17 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Bill Davidsen <davidsen@tmr.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Event logging vs enhancing printk
Message-ID: <1980174169.1018338616@[10.10.2.3]>
In-Reply-To: <Pine.LNX.3.96.1020409103009.26415A-100000@gatekeeper.tmr.com>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   If you want buffering you can add it on a case-by-case basis, but in
> general I don't believe you do want a delay, because the output might be
> lost on a dying system. Prink works like output to stderr, character
> buffered. I would think a change to anything this fundimental would be a
> Linus decision, but I think it's correct as is.

OK, now try to read the panic output when two cpus panic at once ;-)
Been there, sworn vehemently at that ...

There's no point in logging messages if you can't read them afterwards.
I think 99.99% of such cases would not involve printk printing half
a buffered line, then dying, though I admit it's technically possible.

Of course, we could just do this buffering for the event logging half
of the subsystem if people really object. Personally, I think it's a
win to fix printk whilst we're at it, but a half-fix is always an 
option.

M.

