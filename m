Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbULTXhI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbULTXhI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 18:37:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbULTXdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 18:33:47 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:54476 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261675AbULTXbg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 18:31:36 -0500
Subject: Re: swsusp bigdiff [was Re: [PATCH] Software Suspend split to two
	stage V2.]
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@suse.cz>
Cc: hugang@soulinfo.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041120003010.GG1594@elf.ucw.cz>
References: <20041119194007.GA1650@hugang.soulinfo.com>
	 <20041120003010.GG1594@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1103585300.26640.47.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 21 Dec 2004 10:28:21 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Sat, 2004-11-20 at 11:30, Pavel Machek wrote:
> --- clean/Documentation/power/devices.txt	2004-11-03 01:23:03.000000000 +0100
> +++ linux/Documentation/power/devices.txt	2004-11-03 02:16:40.000000000 +0100
> @@ -141,3 +141,82 @@
>  The driver core will not call any extra functions when binding the
>  device to the driver. 
>  
> +pm_message_t meaning
> +
> +pm_message_t has two fields. event ("major"), and flags.  If driver
> +does not know event code, it aborts the request, returning error. Some
> +drivers may need to deal with special cases based on the actual type
> +of suspend operation being done at the system level. This is why
> +there are flags.
> +

I don't know how I managed to miss this before, but I think it's
definitely a step in the right direction. I do wonder, though, if we're
going about this whole thing in a peacemeal approach. I feel like the
whole issue of power state management on the system wide and driver
level are being treated as two separate issues. Is it just me?

Regards,

Nigel
-- 
Nigel Cunningham
Cyclades Software Engineer
Canberra, Australia

http://www.cyclades.com

+61 (2) 6292 8028
+61 (417) 100 574

