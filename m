Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267179AbSLQVeU>; Tue, 17 Dec 2002 16:34:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267184AbSLQVeU>; Tue, 17 Dec 2002 16:34:20 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34064 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267179AbSLQVdv>; Tue, 17 Dec 2002 16:33:51 -0500
Message-ID: <3DFF9A23.1090607@transmeta.com>
Date: Tue, 17 Dec 2002 13:41:55 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021119
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@redhat.com>
CC: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com> <Pine.LNX.4.50.0212162241150.26163-100000@twinlark.arctic.org> <3DFF76D7.2050403@transmeta.com> <20021217163954.D10781@redhat.com>
In-Reply-To: <20021217163954.D10781@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:
> On Tue, Dec 17, 2002 at 11:11:19AM -0800, H. Peter Anvin wrote:
> 
>>>against 0xfffffxxx and "rollback" (or complete) any incomplete
>>>gettimeofday call prior to saving a task's state.  but i bet that test is
>>>undesirable on all interrupt paths.
>>>
>>
>>Exactly.  This is a real problem.
> 
> 
> No, just take the number of context switches before and after the attempt 
> to read the time of day.
> 

How do you do that from userspace, atomically?  A counter in the shared
page?

	-hpa


