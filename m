Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSE3AeY>; Wed, 29 May 2002 20:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315929AbSE3AeX>; Wed, 29 May 2002 20:34:23 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:252 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315928AbSE3AeW>; Wed, 29 May 2002 20:34:22 -0400
Subject: Re: [RFC] [PATCH] Disable TSCs on CONFIG_MULTIQUAD
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: john stultz <johnstul@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1022718054.1963.51.camel@cog>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 May 2002 02:37:55 +0100
Message-Id: <1022722675.4124.337.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-05-30 at 01:20, john stultz wrote:
> Anyway, if you really would rather see what you suggested, I'll happily
> change it (I do like the idea of breaking the CONFIG_X86_TSC_UNSYNCED
> notion out of CONFIG_MULTIQUAD).

Not all the other places are "there is no TSC" most of them deal with
the ability to use a TSC. There are other setups where TSC exists but
isnt usable so distinguishing matters

Also there is one case where TSC that doesn't work matters specifically
- you want to turn off RDTSC access from user space to avoid user space
tools having little accidents

