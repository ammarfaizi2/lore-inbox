Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTK1RIO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 12:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbTK1RIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 12:08:14 -0500
Received: from mail-01.iinet.net.au ([203.59.3.33]:24037 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S262719AbTK1RIK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 12:08:10 -0500
Message-ID: <3FC7803D.2050203@cyberone.com.au>
Date: Sat, 29 Nov 2003 04:05:01 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: Felipe W Damasio <felipewd@elipse.com.br>
CC: Lista da disciplina de Sistemas Operacionais III 
	<sisopiii-l@cscience.org>,
       Ricardo Nabinger Sanchez <rnsanchez@terra.com.br>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [SisopIII-l] Re: [PATCH] fix #endif misplacement
References: <20031128141927.5ff1f35a.rnsanchez@terra.com.br> <Pine.LNX.4.53.0311281732100.21904@gockel.physik3.uni-rostock.de> <3FC77A59.2090705@elipse.com.br>
In-Reply-To: <3FC77A59.2090705@elipse.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Felipe W Damasio wrote:

>     Hi Tim,
>
> Tim Schmielau wrote:
>
>> No, this is exactly what is intended: don't use the TSC on NUMA, use 
>> jiffies instead.
>
>
>     The patch didn't hurt this.
>
>> Look at the comment just above those lines.
>
>
>     The patch doesn't uses jiffies indiscriminately: Only if we're on 
> a NUMA system with !use_tsc.
>
>     Otherwise (on x86 SMP, for example) we use rdtsc...which seems The 
> Right Thing(tm). Hece move the #endif a bit down.


The ifdef isn't pretty, but its performance critical code, its easy to
understand, and there is a big comment above it. I think its OK the
way it is. Not that you would ever notice any difference probably.


