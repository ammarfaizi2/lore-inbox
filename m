Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263064AbUDLUrm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Apr 2004 16:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263088AbUDLUrm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Apr 2004 16:47:42 -0400
Received: from smtp05.web.de ([217.72.192.209]:30428 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263064AbUDLUrk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Apr 2004 16:47:40 -0400
Message-ID: <407B00AE.7010306@web.de>
Date: Mon, 12 Apr 2004 22:48:46 +0200
From: Marcus Hartig <m.f.h@web.de>
Organization: Linux of Borgs
User-Agent: Mozilla Thunderbird 0.5+ (X11/20040406)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm4
References: <407AEBB0.1050305@web.de> <20040412195636.GB12665@mars.ravnborg.org>
In-Reply-To: <20040412195636.GB12665@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:

> I would not be suprised if NVIDIA (and wmware for that matter) takes some
> assumptions which it should not. But I need to find out why it break,
> and for that I need more information!

Yes. I had cut off the whole nVidia install tree. The GLX driver are 
working, but only the kernel module is in /usr/src/nv eg. I change to this 
dir and type "make install" then the Makefile.kbuild for 2.6 tries to 
build it against an 2.6 kernel. Goes with all included -mm3 and others here.

LD [M]  /usr/src/nv/nvidia.o
/bin/sh: line 1: /usr/src/nv/.tmp_versions/nvidia.mod: No such file or 
directory  Building modules, stage 2.
make[1]: Leaving directory `/usr/src/linux-2.6.5-mm4'
nvidia.ko failed to build!
make: *** [module] Error 1

strace gives not more.
Also when I set KBUILD_EXTMOD=/usr/src/nv or to new

KBUILD_PARAMS := -C $(KERNEL_SOURCES) M=$(PWD)

in the Makefile of the nVidia source, I get this error above. Hmm.

Marcus
