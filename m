Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272328AbSISSrG>; Thu, 19 Sep 2002 14:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272329AbSISSrF>; Thu, 19 Sep 2002 14:47:05 -0400
Received: from quark.didntduck.org ([216.43.55.190]:4359 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S272328AbSISSrF>; Thu, 19 Sep 2002 14:47:05 -0400
Message-ID: <3D8A1CC0.8070407@didntduck.org>
Date: Thu, 19 Sep 2002 14:51:44 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard Henderson <rth@twiddle.net>
CC: Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       dvorak <dvorak@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: Syscall changes registers beyond %eax, on linux-i386
References: <24181C771D3@vcnet.vc.cvut.cz> <3D8A11BB.4090100@didntduck.org> <20020919113048.A22520@twiddle.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard Henderson wrote:
> On Thu, Sep 19, 2002 at 02:04:43PM -0400, Brian Gerst wrote:
> 
>>Now that I've thought about it more, I think the best solution is to go 
>>through all the syscalls (a big job, I know), and declare the parameters 
>>as const, so that gcc knows it can't modify them, and will throw a 
>>warning if we try.
> 
> 
> The parameter area belongs to the callee, and it may *always* be modified.
> 
> 
> r~
> 

The parameters can not be modified if they are declared const though, 
that's my point.

--
				Brian Gerst

