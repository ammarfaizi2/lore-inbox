Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVFMSnD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVFMSnD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261194AbVFMSnC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:43:02 -0400
Received: from smtp1.brturbo.com.br ([200.199.201.163]:60109 "EHLO
	smtp1.brturbo.com.br") by vger.kernel.org with ESMTP
	id S261193AbVFMSlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:41:07 -0400
Message-ID: <42ADD33F.3020100@brturbo.com.br>
Date: Mon, 13 Jun 2005 15:41:03 -0300
From: Mauro Carvalho Chehab <mchehab@brturbo.com.br>
User-Agent: Mozilla Thunderbird 1.0.2-3mdk (X11/20050322)
X-Accept-Language: pt-br, pt, es, en-us, en
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
CC: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       video4linux-list@redhat.com
Subject: Re: [PATCH] Adds support for TEA5767 chipset on V4L
References: <42ACAA3B.8050307@brturbo.com.br> <20050613183523.322529e0.khali@linux-fr.org>
In-Reply-To: <20050613183523.322529e0.khali@linux-fr.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jean,

Jean Delvare wrote:

>Hi Mauro,
>
>  
>
>>PS 3: There were some I2C changes that affected V4L on 2.6.12-rc6-mm1.
>>Now, it is necessary to use probe option in tuner to have its I2C
>>addresses recognized by V4L. New patches will come to correct this
>>behavior.
>>    
>>
>
>Which i2c patch please? The changes I made should not cause any trouble
>to V4L drivers. If they do this is a bug, please report it as such.
>  
>
    It is not a bug. The I2C patch has changed some V4L, but it was not
commited to V4L CVS. After making the diff files from CVS to -mm, we
noticed that. Patch07 reaplyed part of the patch. Some other V4L CVS
code had already changed to new behavior.

>Also, a comment on your patch (which I didn't actually review, as I do
>not feel qualified to do so):
>
>  
>
>>+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)
>>+#include "tuner.h"
>>+#include "i2c-compat.h"
>>+#else
>>+#include <media/tuner.h>
>>+#endif
>>    
>>
>
>No such test please, it is useless. This is Linux 2.6.x, no need to
>check this.
>  
>
    There's a script to eliminate this before submiting the patch... For
some reason, as you pointed, it had failed for this code... I'll review
it next time.
    This first sync patch had required so many effort, since there were
changes on both sides. I hope next time having less trouble :-)


