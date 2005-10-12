Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbVJLQGl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbVJLQGl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 12:06:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbVJLQGl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 12:06:41 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:36749 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S1751477AbVJLQGk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 12:06:40 -0400
Message-ID: <434D3493.8020304@rtr.ca>
Date: Wed, 12 Oct 2005 12:06:43 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050728
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: Michael Kerrisk <mtk-lkml@gmx.net>, raa.lkml@gmail.com,
       trond.myklebust@fys.uio.no, boi@boi.at, linux-kernel@vger.kernel.org
Subject: Re: blocking file lock functions (lockf,flock,fcntl) do not return
 after timer signal
References: <Pine.LNX.4.61.0510121112060.4302@chaos.analogic.com> <16960.1129131422@www39.gmx.net> <Pine.LNX.4.61.0510121138450.4391@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0510121138450.4391@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os (Dick Johnson) wrote:
> On Wed, 12 Oct 2005, Michael Kerrisk wrote:
>
>>But this is not correct.  write() is async-signal-safe (POSIX
>>requires it).
>
> Then tell it to the doom-sayers who always excoriate me when
> I use a 'C' runtime library call in test signal code. I have
> been told that the __only__ thing you can do in a signal handler
> is access global memory and/or execute siglongjmp().

Try "man 2 signal", and read the list of signal-safe functions
given at the bottom of the manpage, from POSIX 1003.1-2003.

write() is included (of course it is, since it is really a
kernel syscall not a library function).

Cheers
