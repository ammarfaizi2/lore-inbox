Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261339AbVFDNDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261339AbVFDNDM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 09:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVFDNDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 09:03:11 -0400
Received: from mail.ccur.com ([208.248.32.212]:14979 "EHLO flmx.iccur.com")
	by vger.kernel.org with ESMTP id S261339AbVFDNDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 09:03:06 -0400
Message-ID: <42A1A688.7050505@ccur.com>
Date: Sat, 04 Jun 2005 09:03:04 -0400
From: John Blackwood <john.blackwood@ccur.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.4) Gecko/20050318 Red Hat/1.4.4-1.3.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: akpm@osdl.org, dan@debian.org, bugsy@ccur.com
Subject: Re: [PATCH] ptrace(2) single-stepping into signal handlers
References: <d7q7jf$2s8$1@trex.ccur.com>
In-Reply-To: <d7q7jf$2s8$1@trex.ccur.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jun 2005 13:03:05.0752 (UTC) FILETIME=[BF70C980:01C56905]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > Subject: Re: [PATCH] ptrace(2) single-stepping into signal handlers
 > From: Andrew Morton <akpm@osdl.org>
 > Date: Fri, 3 Jun 2005 16:31:29 -0700
 > To: Daniel Jacobowitz <dan@debian.org>
 > CC: john.blackwood@ccur.com
 >
 > >>> >
 > >>> > Hi Dan,
 > >>> >
 > >>> > I observed this behavior in a 2.6.11.10 kernel.  The code in 
2.6.11.11
 > >>> > looks the same in this area... this is the i386 code that I am 
speaking of.
 > >>> >
 > >>> > I guess that 'some time ago' is more recent than that?
 > >>> >
 > >>> >
 > >>> > If so, then please excuse me... and it's great that this is fixed.
 > >
 > >>
 > >> I'm not sure of the timeline, but could you check that in a current
 > >> 2.6.12 GIT snapshot?
 > >>
 >
 >
 > 2.6.12-rc5 should be sufficient.
 >
 > 
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/testing/linux-2.6.12-rc5.tar.bz2
 >
 > or, even better, the above plus:
 >
 > 
ftp://ftp.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.12-rc5-git8.bz2

Andrew and Dan,

Yes, I tried the above combination, and the stuck-in-single-step mode
after continuing out of the signal handler is indeed FIXED.

Some additional code was added to the i386 version of handle_signal()
(even before the git8 additions) so that the TF flag is now cleared and
the task no longer stops when it comes out of the signal handler and
returns back to the original execution stream.

Thanks.

