Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262475AbREULFn>; Mon, 21 May 2001 07:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262478AbREULFf>; Mon, 21 May 2001 07:05:35 -0400
Received: from t2.redhat.com ([199.183.24.243]:6392 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262475AbREULFS>; Mon, 21 May 2001 07:05:18 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010521060440.A1738@thyrsus.com> 
In-Reply-To: <20010521060440.A1738@thyrsus.com>  <15823.990372866@redhat.com> <20010520114411.A3600@thyrsus.com> <16267.990374170@redhat.com> <20010520131457.A3769@thyrsus.com> <18686.990380851@redhat.com> <20010520164700.H4488@thyrsus.com> <20010520165952.A9622@devserv.devel.redhat.com> <25499.990399116@redhat.com> <20010520211346.A6170@thyrsus.com> <6382.990427297@redhat.com> 
To: esr@thyrsus.com
Cc: Arjan van de Ven <arjanv@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Background to the argument about CML2 design philosophy 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 21 May 2001 12:05:12 +0100
Message-ID: <713.990443112@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



esr@thyrsus.com said:
> I don't think there is a "less contentious" part.  The same people who
> bitched about the engine are now bitching about the changes I'm
> contemplating in the rulesfiles.  It seems clear to me that their
> attitude, in general, has little to do with technical specifics of the
> engine or rulesets and everything to do with resistance to change in
> general and fear of losing control and/or hard-won implicit knowledge
> about the old system.

No. I didn't bitch (much) about CML2 - I'm fairly ambivalent. But I
absolutely object to _unconditionally_ dumbing down the config options, 
because it would hide options which I would frequently want to enable.

Introduce new novice modes if you wish - that seems sensible - but do not
reduce the functionality and flexibility of configuration which is currently
available. Any simplifications you make _must_ be dependent on the novice 
mode, and the default mode should allow the same choices as the current 
rules.

More importantly, do not attempt to force through this change in policy by
sneaking it into the 2.5.1 CML2 patch which introduces the new mechanism. 
The two are entirely orthogonal, and should remain separate.

esr@thyrsus.com said:
>  I'm going to give Linus the same installation kit the people working
> with CML2 have now.  That will include both the CML2 engine and the
> rulesfiles.

Fine. What I'm asking is that you ensure that the CML2 rulesfiles at the
time of the merge implement the dependencies present in the CML1 rulesfiles
immediately prior to the merge.

If you want to work on the change of policy right now, before CML2 is
merged, then go ahead and do it in CML1. It's not difficult. The first step
is to make CONFIG_*_ADVANCED depend on CONFIG_EXPERT, for example. Then get
those changes merged into 2.5 before you merge CML2 - and you still keep the
CML2 after the merge equivalent to the CML1 immediately before the merge.

Otherwise, have patience and do it after CML2 is merged.

All I'm asking is that you refrain from confusing the change in mechanism 
with the change in policy. That's not an unreasonable request, now is it?

--
dwmw2


