Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266434AbUAHACO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 19:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266374AbUAHAAW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 19:00:22 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32193 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265778AbUAGX5T
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 18:57:19 -0500
Message-ID: <3FFC9CC6.6010701@pobox.com>
Date: Wed, 07 Jan 2004 18:56:54 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mike Waychison <Michael.Waychison@Sun.COM>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
References: <1b5GC-29h-1@gated-at.bofh.it> <1b6CO-3v0-15@gated-at.bofh.it> <m3ad50tmlq.fsf@averell.firstfloor.org> <3FFC46EB.9050201@zytor.com> <3FFC7469.3050700@sun.com> <3FFC7469.3050700@sun.com> <3FFC790A.3060206@pobox.com> <3FFC9A76.4070407@sun.com>
In-Reply-To: <3FFC9A76.4070407@sun.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Waychison wrote:
> You wouldn't put a bdflush daemon in userspace either would you?  The 
> loop in question is just that; (overly simplified):
> 
> while (1) {
>     f = ask_kernel_if_anything_looks_inactive();
>     if (f) {
>         try_to_umount(f);
>         continue;
>     } else {
>         sleep(x seconds);
>     }
> }
> 
> My point is, if this is the only active action done by userspace, why 
> open it up to being broken?


You're still using arguments -against- putting software in the kernel. 
You don't decrease software's chances of "being broken" by putting it in 
the kernel, the opposite occurs -- you increase the likelihood of making 
the entire system unstable.  This is one point that Solaris and Win32 
have both missed :)

	Jeff



