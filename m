Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311572AbSC1Dyd>; Wed, 27 Mar 2002 22:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311575AbSC1DyY>; Wed, 27 Mar 2002 22:54:24 -0500
Received: from rwcrmhc54.attbi.com ([216.148.227.87]:6325 "EHLO
	rwcrmhc54.attbi.com") by vger.kernel.org with ESMTP
	id <S311572AbSC1DyI>; Wed, 27 Mar 2002 22:54:08 -0500
Message-ID: <3CA293A3.7040408@didntduck.org>
Date: Wed, 27 Mar 2002 22:53:07 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>, Dave Jones <davej@suse.de>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support (take 2)
In-Reply-To: <Pine.LNX.4.44.0203271802350.8973-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> Vector has been changed as suggested by Maciej.
> 
> Regards,
> 	Zwane

You are missing the asm stub for the interrupt handler.  You can't just 
call C code directly from the interrupt vector.  Look in i8259.c where 
the stubs are for the other APIC interrupts.

-- 

						Brian Gerst

