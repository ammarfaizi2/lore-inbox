Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135296AbRD3O4m>; Mon, 30 Apr 2001 10:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135321AbRD3O4c>; Mon, 30 Apr 2001 10:56:32 -0400
Received: from geos.coastside.net ([207.213.212.4]:3282 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S135296AbRD3O4V>; Mon, 30 Apr 2001 10:56:21 -0400
Mime-Version: 1.0
Message-Id: <p05100303b7132cc78a3e@[207.213.214.37]>
In-Reply-To: <3AED145F.84E95D8D@transmeta.com>
In-Reply-To: <3AEBF782.1911EDD2@mandrakesoft.com>	
 <Pine.LNX.4.33.0104290914260.14261-100000@twinlark.arctic.org>
 <15085.3587.865614.360094@pizda.ninka.net>
 <3AED145F.84E95D8D@transmeta.com>
Date: Mon, 30 Apr 2001 07:56:03 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 12:29 AM -0700 2001-04-30, H. Peter Anvin wrote:
>"David S. Miller" wrote:
>>
>>  dean gaudet writes:
>>   > i was kind of solving a different problem with the code page 
>>though -- the
>>   > ability to use rdtsc on SMP boxes with processors of varying speeds and
>>   > synchronizations.
>>
>>  A better way to solve that problem is the way UltraSPARC-III do and
>>  future ia64 systems will, by way of a "system tick" register which
>>  increments at a constant rate regardless of how the cpus are clocked.
>>
>>  The "system tick" pulse goes into the processor, so it's still a local
>>  cpu register being accessed.  Think of it as a system bus clock cycle
>>  counter.
>>
>>  Granted, you probably couldn't make changes to the hardware you were
>>  working on at the time :-)
>>
>
>RDTSC in Crusoe processors does basically this.
>
>	-hpa

The Pentium III TSC has the bizarre characteristic, per Intel docs 
anyway, that only the low half can be written (as I recall the high 
half gets set to zero), making restoration problematical in certain 
power-management regimes. Hopefully the Crusoe does better.
-- 
/Jonathan Lundell.
