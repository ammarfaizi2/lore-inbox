Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263976AbUCZIxU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 03:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263977AbUCZIxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 03:53:20 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:2982 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263976AbUCZIxP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 03:53:15 -0500
Message-ID: <4063EEC1.9080203@stesmi.com>
Date: Fri, 26 Mar 2004 09:50:09 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
       239952@bugs.debian.org, debian-devel@lists.debian.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
References: <E1B6Izr-0002Ai-00@r063144.stusta.swh.mhn.de>	 <20040325082949.GA3376@gondor.apana.org.au>	 <20040325220803.GZ16746@fs.tum.de>  <40635DD9.8090809@pobox.com> <1080260235.3643.103.camel@imladris.demon.co.uk>
In-Reply-To: <1080260235.3643.103.camel@imladris.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David.

> The firmware blob in question can be reasonably considered to be an
> independent and separate work in itself. The GPL doesn't apply to it
> when it is distributed as a SEPARATE work. But when you distribute it as
> part of a whole which is a work based on other parts of the kernel, by
> including it in the kernel source in such a manner, the distribution of
> the whole must be on the terms of the GPL, whose permissions for other
> licensees extend to the entire whole, and thus to each and every part.
> 
> It's not the intent of the GPL to claim rights to firmware written
> independently for such hardware; rather, the intent is to exercise the
> right to control the distribution of _COLLECTIVE_ works based on the
> indisputably GPL'd parts of the kernel.
> 

But the firmware comes after a GPL statement thereby leading to the
conclusion that it is their INTENTION to GPL the firmware.

If we have a source:

--

/*
     This file is under the GPL, yada yada
*/
#include "things.h"

void some_func(void)
{
   does_something();
}

char firmware[]={0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07};

void upload_firmware(void)
{
   do_upload(firmware);
}

--

Then it seems clear to me that the firmware is under the GPL because it
is PART of the GPL'd file. If not, then I don't see how any statement
can ever be true to similar effect, even for some_func().

// Stefan
