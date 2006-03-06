Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbWCFMRd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbWCFMRd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 07:17:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932119AbWCFMRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 07:17:33 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:32913 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932107AbWCFMRc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 07:17:32 -0500
Message-ID: <440C2853.7090700@aitel.hist.no>
Date: Mon, 06 Mar 2006 13:17:23 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, gregkh@suse.de,
       Tilman Schmidt <tilman@imap.cc>
Subject: Re: 2.6.16-rc5-mm2 compile error in urb.c
References: <20060303045651.1f3b55ec.akpm@osdl.org>	<440BFC8A.1030607@aitel.hist.no> <20060306012141.5d8ca46f.akpm@osdl.org>
In-Reply-To: <20060306012141.5d8ca46f.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Helge Hafting <helge.hafting@aitel.hist.no> wrote:
>  
>
>>Compiling 2.6.16-rc5-mm2 stopped here:
>>
>>  CC      drivers/usb/core/urb.o
>>drivers/usb/core/urb.c: In function ___usb_alloc_urb___:
>>drivers/usb/core/urb.c:65: error: dereferencing pointer to incomplete type
>>drivers/usb/core/urb.c: In function ___usb_submit_urb___:
>>drivers/usb/core/urb.c:329: error: dereferencing pointer to incomplete type
>>make[3]: *** [drivers/usb/core/urb.o] Error 1
>>make[2]: *** [drivers/usb/core] Error 2
>>make[1]: *** [drivers/usb] Error 2
>>make: *** [drivers] Error 2
>>
>>    
>>
>
>I guess this is gregkh-usb-usb-reduce-syslog-clutter.patch trying to
>dereference THIS_MODULE when the driver is being built into vmlinux.  I
>suggest you revert that patch, thanks.
>  
>
Thanks. Reverting this gave me a kernel that compiled and booted.

Helge Hafting
