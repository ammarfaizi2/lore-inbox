Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbVFKNXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbVFKNXs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 09:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVFKNXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 09:23:48 -0400
Received: from relay04.roc.ny.frontiernet.net ([66.133.182.167]:36002 "EHLO
	relay04.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S261699AbVFKNXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 09:23:46 -0400
Message-ID: <42AAE5C8.9060609@xfs.org>
Date: Sat, 11 Jun 2005 08:23:20 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: =?ISO-8859-1?Q?Pozs=E1r_Bal=E1zs?= <pozsy@uhulinux.hu>,
       linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
References: <42A99D9D.7080900@xfs.org> <20050610112515.691dcb6e.akpm@osdl.org> <20050611082642.GB17639@ojjektum.uhulinux.hu>
In-Reply-To: <20050611082642.GB17639@ojjektum.uhulinux.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pozsár Balázs wrote:
> On Fri, Jun 10, 2005 at 11:25:15AM -0700, Andrew Morton wrote:
> 
>>I wonder if rather than the intermittency being time-based, it is
>>load-address-based?  For example, suppose there's a bug in the symbol
>>lookup code?
> 
> 
> Just a data point: I met the same problem with 2.6.12-rc5, using
> gcc 3.3.4.
> I think it's time-based issue, because I was playing around with the 
> initscripts, and the bug shows up when there are lots of modprobes in a 
> short time.
> 
>

I think this is not actually module loading itself, but a problem
between the fork/exec/wait code in nash and the kernel. The
commands which have problems are the ones which are not built
into nash. So this looks more like a problem with wait. This
would explain sleep fixing it and the fact that I have device
issues after module load.

Steve
