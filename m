Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318227AbSHKSvV>; Sun, 11 Aug 2002 14:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318237AbSHKSvV>; Sun, 11 Aug 2002 14:51:21 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:19956 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318227AbSHKSvU>; Sun, 11 Aug 2002 14:51:20 -0400
Subject: Re: [PATCH] tsc-disable_B9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, Leah Cunningham <leahc@us.ibm.com>,
       wilhelm.nuesser@sap.com, paramjit@us.ibm.com, msw@redhat.com
In-Reply-To: <1028915214.1117.46.camel@cog>
References: <1028771615.22918.188.camel@cog> 
	<1028812663.28883.32.camel@irongate.swansea.linux.org.uk> 
	<1028860246.1117.34.camel@cog> 
	<1028884665.28882.173.camel@irongate.swansea.linux.org.uk> 
	<1028915214.1117.46.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 11 Aug 2002 21:16:17 +0100
Message-Id: <1029096977.16424.39.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 18:46, john stultz wrote:
> Oh yes, with the old NUMAQ hardware here, one can mix nodes of different
> speed cpus. Once I get a chance, I'm going to begin working on this
> issue for 2.5. My plan right now is to keep per-cpu last_tsc_low and 
> fast_gettimeoffset_quotient values, then round robin the timer
> interrupt. 

I wouldn't worry too much about it. With a pre-emptible kernel in 2,5
the tsc using code can jump processors and get disturbed. The right
answer is not to use tsc for time clocks unless we have no other good
option. Stuff like HPET will help no end

Alan

