Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316661AbSEQTZs>; Fri, 17 May 2002 15:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSEQTZr>; Fri, 17 May 2002 15:25:47 -0400
Received: from mailout08.sul.t-online.com ([194.25.134.20]:19102 "EHLO
	mailout08.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S316661AbSEQTZp>; Fri, 17 May 2002 15:25:45 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, dipankar@in.ibm.com
Subject: Re: 16-CPU #s for lockfree rtcache (rt_rcu)
In-Reply-To: <20020517192116.G12631@in.ibm.com> <20020517.064921.80183164.davem@redhat.com> <20020517214433.A15556@in.ibm.com> <20020517.094624.68229633.davem@redhat.com>
From: Andi Kleen <ak@muc.de>
Date: 17 May 2002 21:25:16 +0200
Message-ID: <m37km2vaoz.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.070095 (Pterodactyl Gnus v0.95) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

>    From: Dipankar Sarma <dipankar@in.ibm.com>
>    Date: Fri, 17 May 2002 21:44:33 +0530
>    
>    I will rerun the tests tomorrow or monday to get both sets of
>    numbers for 8-cpu  SMP.
> 
> Provide the data, it will be interesting.

I bet the numbers would be much better if the x86 
do_gettimeofday() was converted to a lockless version first ...
Currently it is bouncing around its readlock for every incoming packet.

-Andi

