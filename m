Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136590AbREBC06>; Tue, 1 May 2001 22:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136738AbREBC0s>; Tue, 1 May 2001 22:26:48 -0400
Received: from femail2.sdc1.sfba.home.com ([24.0.95.82]:689 "EHLO
	femail2.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S136590AbREBC0e>; Tue, 1 May 2001 22:26:34 -0400
Message-ID: <3AEF7054.ADE37AF4@home.com>
Date: Tue, 01 May 2001 19:26:28 -0700
From: Seth Goldberg <bergsoft@home.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Followup to previous post: Atlon/VIA Instabilities
In-Reply-To: <3AEF346D.FB01EAE9@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:
> 
> > So it seems that CONFIG_X86_USE_3DNOW is simply used to
> > enable access to the routines in mmx.c (the athlon-optimized
> > routines on CONFIG_K7 kernels), so then it appears that somehow
> > this is corrupting memory / not behaving as it should (very
> > technical, right?) :)...
> 
> Do you use any unusual (binary only/with source) kernel modules?
> 
> mmx.c stores the current contents on the fpu registers into
> current->thread.i387.f{,x}save.
> If another module modifes the fpu registers and calls memmove it will
> cause fpu corruptions.
> 
> I checked that a few months ago, and no module in the main kernel tree
> does that.

  No, actually the instability starts right after/when the root
filesystem is mounted (it seems).  I have no foreign modules installed
when this error occurs.  Even if I did, why would the Abit KA7 with the
same [other] hardware and software NOT show this problem, even with all
opts enabled?

 --Seth
