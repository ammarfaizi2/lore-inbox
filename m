Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266211AbUAVKWM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 05:22:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266212AbUAVKWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 05:22:12 -0500
Received: from 213-229-38-66.static.adsl-line.inode.at ([213.229.38.66]:20966
	"HELO mail.falke.at") by vger.kernel.org with SMTP id S266211AbUAVKWJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 05:22:09 -0500
Message-ID: <400FA3CD.1030008@winischhofer.net>
Date: Thu, 22 Jan 2004 11:19:57 +0100
From: Thomas Winischhofer <thomas@winischhofer.net>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en, de, de-de, de-at, sv
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] sisfb update 2.6.1
References: <400F0F8C.8070900@winischhofer.net>	<20040121160309.2fd26f0a.akpm@osdl.org>	<400F9055.5050206@winischhofer.net> <20040122012312.1f26fad8.akpm@osdl.org>
In-Reply-To: <20040122012312.1f26fad8.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andrew Morton wrote:
> 
> Well darn, that patch fixed the wrong bit and we still have float in there.
> allmodconfig doesn't pick this up.
> 
> 
> drivers/built-in.o: In function `sisfb_do_set_var':
> //drivers/video/sis/sis_main.c:654: undefined reference to `__floatsidf'
> ...
> drivers/built-in.o: In function `sisfb_init':
> //drivers/video/sis/sis_main.c:4450: undefined reference to `__floatsidf'
> 
> Search for "1E12" in sis_main.c

I did. "Not found."

Compiles and links wonderfully here.... erm yes, WITH mfloat.

Search for "1000000000" in sis_main.c. If you don't find this, you 
didn't apply the patch ;)

With what value is "VER_LEVEL" in sis_main.h #defined? Should be 25.

Me confused....

Thomas

-- 
Thomas Winischhofer
Vienna/Austria
thomas AT winischhofer DOT net          *** http://www.winischhofer.net/
twini AT xfree86 DOT org



