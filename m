Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262001AbTCZUBv>; Wed, 26 Mar 2003 15:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262062AbTCZUBu>; Wed, 26 Mar 2003 15:01:50 -0500
Received: from vbws78.voicebs.com ([66.238.160.78]:30727 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S262001AbTCZUA3>; Wed, 26 Mar 2003 15:00:29 -0500
Message-ID: <3E82097A.2040306@didntduck.org>
Date: Wed, 26 Mar 2003 15:11:38 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; WinNT4.0; en-US; rv:1.3) Gecko/20030312
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ravikumar.chakaravarthy@amd.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to turn paging on!!
References: <99F2150714F93F448942F9A9F112634CA54B3A@txexmtae.amd.com>
In-Reply-To: <99F2150714F93F448942F9A9F112634CA54B3A@txexmtae.amd.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ravikumar.chakaravarthy@amd.com wrote:
> I tweaked the kernel and boot loader to load the kernel at 0xdf000000, physical address. I did the following changes to setup the initial page table.
> 
> However during boot, in arch/i386/kernel/head.S when the paging bit is set 
>        movl %eax,%cr0          /* ..and set paging (PG) bit */
> 
> My computer hangs!!
> 
> Any idea why??
> 
>   -Ravi

The kernel can only be loaded into memory that is directly mapped, which 
is the first 960MB.  Why do you need to change the load address?

--
				Brian Gerst

