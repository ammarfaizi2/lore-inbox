Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316088AbSHFWcS>; Tue, 6 Aug 2002 18:32:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316089AbSHFWcS>; Tue, 6 Aug 2002 18:32:18 -0400
Received: from jalon.able.es ([212.97.163.2]:49111 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316088AbSHFWcS>;
	Tue, 6 Aug 2002 18:32:18 -0400
Date: Wed, 7 Aug 2002 00:35:50 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: Marc-Christian Petersen <mcp@linux-systeme.de>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: AIO together with SMPtimers-A0 oops and freezing
Message-ID: <20020806223550.GC2733@werewolf.able.es>
References: <200208051920.29018.mcp@linux-systeme.de> <20020806160724.A19564@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20020806160724.A19564@redhat.com>; from bcrl@redhat.com on Tue, Aug 06, 2002 at 22:07:24 +0200
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.08.06 Benjamin LaHaise wrote:
>On Mon, Aug 05, 2002 at 07:20:29PM +0200, Marc-Christian Petersen wrote:
>> Hi Ben, Hi Ingo,
>
>> Ben, I am using your AIO 20020619 patch + relevant fixes from the AIO 
>> mailinglist together with your patch Ingo, SMPtimers-A0.
>
>Hmmm, the only problem I can see in the aio code wrt timer usage is 
>the following.  Does this patch make a difference?  If not, I'm guessing 
>that the problem is something in SMPtimers-A0 that aio happens to 
>trigger.  The only timer aio uses is for the timeout when waiting for an 
>event, and the structure for that is put on the stack.
>

Hmm, I forgot to comment, but I apply smptimers on top of latest -aa, that
includes aio (is it different implementation?), and the kernel works fine.
 
-- 
J.A. Magallon             \   Software is like sex: It's better when it's free
mailto:jamagallon@able.es  \                    -- Linus Torvalds, FSF T-shirt
Linux werewolf 2.4.19-jam0, Mandrake Linux 9.0 (Cooker) for i586
gcc (GCC) 3.2 (Mandrake Linux 9.0 3.2-0.2mdk)
