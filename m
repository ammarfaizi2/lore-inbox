Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269743AbUJAK2H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269743AbUJAK2H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 06:28:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269748AbUJAK2G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 06:28:06 -0400
Received: from [80.227.59.61] ([80.227.59.61]:43139 "EHLO HasBox.COM")
	by vger.kernel.org with ESMTP id S269743AbUJAK1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 06:27:53 -0400
Message-ID: <415D311E.2050006@0Bits.COM>
Date: Fri, 01 Oct 2004 14:27:42 +0400
From: Mitch DSouza <Mitch@0Bits.COM>
User-Agent: Application 0.6+ (X11/20041001)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Pavel,

I thought i was going barmy. I've reverted back to -rc2 which
pmdisk works flawlessly on my laptop.

Thanks
Mitch

-------- Original Message --------
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
Date: Fri, 1 Oct 2004 12:23:51 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Mitch <Mitch@0Bits.COM>
CC: linux-kernel@vger.kernel.org
References: <415C2633.3050802@0Bits.COM>

Hi!

> Anyone noticed that pmdisk software suspend stopped working in -rc3 ?
> In -rc2 it worked just fine. My script was
> 
>  chvt 1
>  echo -n shutdown >/sys/power/disk
>  echo -n disk >/sys/power/state
>  chvt 7
> 
> In -rc3 it appears to write pages out to disk, but never shuts down the
> machine. Is there something else i need to do or am missing ?

You are not missing anything, it is somehow broken. I'll try to find
out what went wrong and fix it. In the meantime, look at -mm series,
it works there.
								Pavel

