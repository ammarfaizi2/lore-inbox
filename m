Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316161AbSHIUvQ>; Fri, 9 Aug 2002 16:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316185AbSHIUvQ>; Fri, 9 Aug 2002 16:51:16 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:13236 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S316161AbSHIUvP>;
	Fri, 9 Aug 2002 16:51:15 -0400
Message-ID: <3D542C06.50008@us.ibm.com>
Date: Fri, 09 Aug 2002 13:54:30 -0700
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Badari Pulavarty <pbadari@us.ibm.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at /usr/src/linux-2.5.30/include/linux/dcache.h:261!
References: <200208091732.g79HW4q02868@eng2.beaverton.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Badari Pulavarty wrote:
> Code;  c0160d0f <d_unhash+f/70>   <=====
>    0:   0f 0b                     ud2a      <=====
> Code;  c0160d11 <d_unhash+11/70>
>    2:   05 01 00 db 2a            add    $0x2adb0001,%eax
> Code;  c0160d16 <d_unhash+16/70>
>    7:   c0                        (bad)  

Doesn't that (bad) instruction look suspicious?  Martin was seeing 
strange oopses on Hummer (16-way NUMA-Q) compiling with egcs 2.91 
because it was generating bad instructions.  It may be another 
problem, but that c0 jumped out at me.  The two instructions after it 
look bretty bogus too.

-- 
Dave Hansen
haveblue@us.ibm.com

