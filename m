Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291172AbSAaRbP>; Thu, 31 Jan 2002 12:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291171AbSAaRbF>; Thu, 31 Jan 2002 12:31:05 -0500
Received: from air-1.osdl.org ([65.201.151.5]:14240 "EHLO segfault.osdlab.org")
	by vger.kernel.org with ESMTP id <S291172AbSAaRa5>;
	Thu, 31 Jan 2002 12:30:57 -0500
Date: Thu, 31 Jan 2002 09:32:00 -0800 (PST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@segfault.osdlab.org>
To: Luigi Genoni <kernel@Expansa.sns.it>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.3 does not compile on sparc64
In-Reply-To: <Pine.LNX.4.44.0201311823570.21203-100000@Expansa.sns.it>
Message-ID: <Pine.LNX.4.33.0201310930130.800-100000@segfault.osdlab.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 31 Jan 2002, Luigi Genoni wrote:

> Yes, but the error do persist also with this patch,
> probably my english was unclear.
> I changes the include, because otherway I was getting
> a no such file message, after the change I got this error
> message.
> I should add that gcc for sparc64 to compile a 64 bit kernel is just egcs
> 1.1.2, because gcc 2.95 and following have problems to compile at 64 bit
> of sparc.

Ah, I see. 

So, you're getting this error:

core.c:179: parse error before `device_init_root'
core.c:180: warning: return-type defaults to `int'
core.c:185: parse error before `device_driver_init'
core.c:186: warning: return-type defaults to `int'

If you add 

#include <linux/init.h>

does it compile?

	-pat


