Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSE2Vsv>; Wed, 29 May 2002 17:48:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSE2Vsu>; Wed, 29 May 2002 17:48:50 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:35321 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315539AbSE2Vst>; Wed, 29 May 2002 17:48:49 -0400
Subject: Re: [RFC] [PATCH] Disable TSCs on CONFIG_MULTIQUAD
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1022704850.1963.18.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 29 May 2002 23:52:16 +0100
Message-Id: <1022712736.9255.289.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-29 at 21:40, john stultz wrote:
> Hi all,
> 	Just wanted to submit this for comments. As we've been having trouble
> keeping the TSCs on NUMA hardware synced (resulting in gettimeofday
> occasionally going backward), this patch (against 2.4.18) disables TSCs
> if CONFIG_MULTIQUAD is enabled. Any suggestions for simplifying the
> changes to config.in would be appreciated. 

Add CONFIG_X86_TSC_NOT_SYNCHRONOUS or similar and then check

#if defined(CONFIG_X86_TSC) && !defined(CONFIG_X86_NOT_SYNCHRONOUS))


??

 
