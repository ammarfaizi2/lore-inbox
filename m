Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315922AbSEZUeA>; Sun, 26 May 2002 16:34:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315946AbSEZUeA>; Sun, 26 May 2002 16:34:00 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:46836 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315922AbSEZUd6>; Sun, 26 May 2002 16:33:58 -0400
Subject: Re: [PATCH] [2.4] [2.5] [i386] Add support for GCC 3.1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: rwhron@earthlink.net
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020526160217.A1343@rushmore>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 26 May 2002 22:36:11 +0100
Message-Id: <1022448971.11811.145.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-05-26 at 21:02, rwhron@earthlink.net wrote:
> Another processor config could be CONFIG_K62.
> gcc-3.1 -march=k6-2 benchmarks a little better 
> than -march=k6.  Adding CONFIG_XF86_USE_3DNOW=y 
> seems to help a little too.

Make sure you benchmark FPU intensive use when testing USE_3DNOW. I've
seen several situations where it looks marginally better until you
actually measure two things - memory bandwidth available to user
programs, and also FPU performance, especially of FPU heavy apps that
schedule a lot (eg Quake)

