Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316392AbSETVVU>; Mon, 20 May 2002 17:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316393AbSETVVT>; Mon, 20 May 2002 17:21:19 -0400
Received: from jalon.able.es ([212.97.163.2]:58606 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316392AbSETVVS>;
	Mon, 20 May 2002 17:21:18 -0400
Date: Mon, 20 May 2002 23:21:09 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Anton Blanchard <anton@samba.org>
Cc: Dipankar Sarma <dipankar@in.ibm.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Dave Miller <davem@redhat.com>
Subject: Re: [RFC][PATCH] TIMER_BH-less smptimers
Message-ID: <20020520212109.GA5821@werewolf.able.es>
In-Reply-To: <20020516185448.A8069@in.ibm.com> <20020520085500.GB14488@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.05.20 Anton Blanchard wrote:
>
>Hi Dipankar,
>
>> I have been experimenting with Ingo's smptimers and I ended up
>> extending it a little bit. I would really appreciate comments
>> on whether these things make sense or not.
>
>I tried it out and found that we were context switching like crazy.
>It seems we were always running the timers out of a tasklet because
>we never unlocked the net_bh_lock.
>

The patch for 2.4 in

http://people.redhat.com/mingo/scalable-timers-patches/

does not acquire net_bh_lock. Then I suppose it does not apply to that ?

So this patch is a little outdated wrt the one for 2.5. Is there any
updated version available for 2.4 ?
Can I try your patch for 2.5 on 2.4 or is there any infrastructure
missing ?

TIA

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam3 #1 SMP dom may 19 21:07:40 CEST 2002 i686
