Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbUKQSE7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbUKQSE7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:04:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262456AbUKQSEl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:04:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:2198 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262452AbUKQSAp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:00:45 -0500
Message-ID: <419B8EC0.2070005@osdl.org>
Date: Wed, 17 Nov 2004 09:47:44 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@bytesex.org>
CC: jelle@foks.8m.com, lkml <linux-kernel@vger.kernel.org>,
       akpm <akpm@osdl.org>
Subject: Re: [PATCH] cx88: fix printk arg. type
References: <419A89A3.90903@osdl.org> <20041117172519.GB8176@bytesex>
In-Reply-To: <20041117172519.GB8176@bytesex>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
>>-		dprintk(0, "ERROR: Firmware size mismatch (have %ld, expected %d)\n",
>>+		dprintk(0, "ERROR: Firmware size mismatch (have %Zd, expected %d)\n",
> 
> 
> Thanks, merged to cvs.  I like that 'Z'.  Or is that just a linux-kernel
> printk specific thingy?  Or is this standardized somewhere?  So I could
> use that in userspace code as well maybe?

Kernel supports/allows 'Z' or 'z'.
C99 spec defines 'z' only as a size_t format length modifier:

z   Specifies that a following d, i, o, u, x, or X conversion 
specifier applies to a size_t or the corresponding signed integer type 
argument; or that a following n conversion specifier applies to a 
pointer to a signed integer type corresponding to size_t argument.

Anyway, I agree with Al.  Will you please change it to
'z' instead of 'Z'?

Thanks,
-- 
~Randy
