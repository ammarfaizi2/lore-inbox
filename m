Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315370AbSHAO5i>; Thu, 1 Aug 2002 10:57:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315406AbSHAO5h>; Thu, 1 Aug 2002 10:57:37 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:15307 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S315370AbSHAO5h>; Thu, 1 Aug 2002 10:57:37 -0400
Message-ID: <3D494CFF.245675E@nortelnetworks.com>
Date: Thu, 01 Aug 2002 11:00:15 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Pavel Machek <pavel@elf.ucw.cz>, Andrea Arcangeli <andrea@suse.de>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       linux-aio@kvack.org
Subject: Re: [rfc] aio-core for 2.5.29 (Re: async-io API registration for 2.5.29)
References: <20020730054111.GA1159@dualathlon.random> <20020730084939.A8978@redhat.com> <20020730214116.GN1181@dualathlon.random> <20020730175421.J10315@redhat.com> <20020731004451.GI1181@dualathlon.random> <20020801103011.GB159@elf.ucw.cz> <20020801104707.B21032@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

> After thinking about it further, there is one problem with when that is
> avoided with timeout: if the system time is changed between the timeout
> calculation and the time the kernel calculates the jiffies offset, the
> process could be delayed much longer than desired (and fixing this case
> is hard enough that it should be avoided in typical code).  Tradeoffs...

Now if we had a constant monotonic source of time--say 64-bit nanoseconds since
boot--this wouldn't be a problem.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
