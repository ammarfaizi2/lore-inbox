Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289523AbSAJQTQ>; Thu, 10 Jan 2002 11:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289524AbSAJQTG>; Thu, 10 Jan 2002 11:19:06 -0500
Received: from 12-237-170-171.client.attbi.com ([12.237.170.171]:23426 "EHLO
	wf-rch.cirr.com") by vger.kernel.org with ESMTP id <S289523AbSAJQSz>;
	Thu, 10 Jan 2002 11:18:55 -0500
Message-ID: <3C3DBF5F.4070603@acm.org>
Date: Thu, 10 Jan 2002 10:20:47 -0600
From: Corey Minyard <minyard@acm.org>
User-Agent: Mozilla/5.0 (X11; U; Linux ppc; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Moving zlib so that others may use it
In-Reply-To: <3C3D1743.40900@acm.org> <24080.1010637887@kao2.melbourne.sgi.com> <20020110153657.GY13931@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:

>
>It's possible they can share, but the bootloaders (PPC & MIPS) need a
>slight change to the zlib.c code to to allow using zero as a real
>address to store the uncompressed data.  So we'd want to guard the
>changes with __BOOTER__ or so, and then cp the file or do
>#define __BOOTER__
>#include "zlib.c"
>
>And do -I$(TOPDIR)/lib, or something along those lines.
>

I agree, but I think it would be better to do this one step at a time. 
 Let's get the things in the kernel working first to get rid of the 
namespace crash, then get the bootloaders to share the code.  I can't 
test out a lot of the code, so I can't really do the bootloader changes, 
and the bootloader changes are completely independent, anyway, once zlib 
is moved.

-Corey


