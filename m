Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268896AbRHKW1x>; Sat, 11 Aug 2001 18:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268897AbRHKW1n>; Sat, 11 Aug 2001 18:27:43 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:59662 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S268896AbRHKW1c>; Sat, 11 Aug 2001 18:27:32 -0400
Message-ID: <3B75B2A8.2E8A42EE@zip.com.au>
Date: Sat, 11 Aug 2001 15:33:12 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo@conectiva.com.br>
CC: Daniel Phillips <phillips@bonn-fries.net>,
        lkml <linux-kernel@vger.kernel.org>, Zach Brown <zab@osdlab.org>,
        linux-mm@kvack.org
Subject: Re: vmstats patch against 2.4.8pre7 and new userlevel hack
In-Reply-To: <01081022333100.00293@starship> <Pine.LNX.4.21.0108111349500.17282-100000@freak.distro.conectiva>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> 
> > Problem: none of the statistics show up in proc until the first time the
> > kernel hits them.  The /proc/stats entry isn't even there until the kernel
> > hits the first statistic.  This isn't user-friendly.
> 
> Right. This has to be fixed.
> 

Does it?  The userspace tool can just assume the value is zero
if it isn't available.

If we want unencountered counters to appear in the summary
we'd have to declare them, which means two lines of code
rather than one :)
