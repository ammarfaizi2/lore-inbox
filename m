Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270418AbUJUVG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270418AbUJUVG2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270844AbUJUVDB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:03:01 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:42374 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S270836AbUJUVBW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:01:22 -0400
Message-ID: <4178232B.5000506@rtr.ca>
Date: Thu, 21 Oct 2004 16:59:23 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4.28-pre4-bk6] delkin_cb: new driver for Cardbus IDE
 CF adaptor
References: <41780393.3000606@rtr.ca>	 <58cb370e041021121317083a3a@mail.gmail.com> <41781B13.3030803@rtr.ca> <58cb370e041021134269c05f17@mail.gmail.com>
In-Reply-To: <58cb370e041021134269c05f17@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej!

Bartlomiej Zolnierkiewicz wrote:
>
> Just port it to 2.6.x...

 From my current negative experiences with 2.6.xx, I'll pass.
That kernel breaks suspend/resume on my notebooks,
and is a dog for disk performance.  Still, I'd happily
port this new driver to it if there was a hope in hell
that the effort wouldn't be a total waste of my time.

 > ide_unregister() is disallowed, unless IDE locking is fixed

That just happens to be the existing interface used by the existing
PCMCIA layer.  The new delkin_cb driver simply does exactly the
same calls to link in/out of the kernel as ide-cs does today.

I suppose that means we should remove ide-cs as well.

Cheers
-- 
Mark Lord
(hdparm keeper & the original "Linux IDE Guy")
