Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272967AbRIHGj5>; Sat, 8 Sep 2001 02:39:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272968AbRIHGji>; Sat, 8 Sep 2001 02:39:38 -0400
Received: from smtp6.mindspring.com ([207.69.200.110]:58384 "EHLO
	smtp6.mindspring.com") by vger.kernel.org with ESMTP
	id <S272967AbRIHGjW> convert rfc822-to-8bit; Sat, 8 Sep 2001 02:39:22 -0400
Subject: Re: Linux Preemptive patch success 2.4.10-pre4 + lots of other
From: Robert Love <rml@tech9.net>
To: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <200109080629.f886TrG13025@zero.tech9.net>
In-Reply-To: <200109080629.f886TrG13025@zero.tech9.net>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/0.13.99+cvs.2001.09.05.07.08 (Preview Release)
Date: 08 Sep 2001 02:39:51 -0400
Message-Id: <999931193.838.25.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2001-09-08 at 02:29, Dieter Nützel wrote:
> I've tested your former patch against 2.4.7-acX and sent you some feedback 
> but you didn't answered my post.
>
> Is the module problem (missing preempt_xxx symbols) thing fixed?

I am not sure what module problem you are talking about.  There was a
bug in my original patch that caused a link error in most situations
where CONFIG_MODULE was set, but this had to do with
atomic_dec_and_lock, not preempt_xxx -- what preempt_xxx symbols?

Anyhow, I suggest you grab 2.4.9-ac10 and
http://tech9.net/rml/linux/patch-rml-2.4.9-ac10-preempt-kernel-1 and
enable CONFIG_PREEMPT and give that a whirl.  You should have no
problems on a UP system.

> Aside from that I saw some nice speed increase (UP Athlon) and very snappy 
> system.

Very glad.  Especially to hear there are no problems on Athlon.

> dbench-1.1 32 clients load drops to mostly below 16 (33 before)

Great.  Data points such as this are welcome.  What about the actual
throughput?  Both I and Nigel (see http://kpreempt.sourceforge.net) 
benched the patch with `dbench -16' and we both got decent throughput
increase.

> Go on with your great work!

Thanks.

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

