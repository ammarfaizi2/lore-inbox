Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263075AbTI3BSE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 21:18:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263081AbTI3BSE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 21:18:04 -0400
Received: from dyn-ctb-210-9-243-176.webone.com.au ([210.9.243.176]:30468 "EHLO
	chimp.local.net") by vger.kernel.org with ESMTP id S263075AbTI3BSB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 21:18:01 -0400
Message-ID: <3F78D9A3.1070906@cyberone.com.au>
Date: Tue, 30 Sep 2003 11:17:23 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Stephen Anthony <stephena@users.sourceforge.net>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Possible regression with 2.6.0-test6
References: <200309290822.09859.stephena@users.sourceforge.net>
In-Reply-To: <200309290822.09859.stephena@users.sourceforge.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Stephen Anthony wrote:

>I've noticed that test6 isn't as 'smooth' as test5.  Specifically, if I 
>open an nedit window and use the cursor down key to scroll down through 
>text, there is some jerkiness.  At this point I've noticed that CPU use 
>goes to 1% or more.  A similar problem happens with Opera (web browser), 
>but of course the CPU usage is higher, which is expected.
>
>When I go back to test5, scrolling in nedit is smoother, and CPU never 
>goes above 0.6%.  Note that the speed that text moves is the same in 
>both, but the test6 version 'jumps' and 'stops' for a little bit.  Hence 
>my describing it as jerky.
>
>I know its not much to go on, but it is a noticable difference, at least 
>to me.  Since this new release has tweaked interactivity patches, I'm 
>wondering if this has anything to do with it.
>
>System is a fully updated Mandrake 9.1, but I don't think that would 
>matter.  CPU is P4-2.4GHz with 768 MB RAM, and NVidia video card.
>

Hi Stephen, the new CPU scheduler is likely to be the change. You need
to first make sure your X server is not reniced to -10 (should be at 0).

If that fails to help, then you could try my scheduler (with X at -10!)
http://www.kerneltrap.org/~npiggin/v15a/sched-rollup-v15a-260t6.gz

