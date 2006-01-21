Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751087AbWAUJKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbWAUJKD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 04:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751104AbWAUJKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 04:10:03 -0500
Received: from smtp.osdl.org ([65.172.181.4]:12176 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751087AbWAUJKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 04:10:01 -0500
Date: Sat, 21 Jan 2006 01:09:32 -0800
From: Andrew Morton <akpm@osdl.org>
To: "Carlo E. Prelz" <fluido@fluido.as>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATI RS480-based motherboard: stuck while booting with kernel >=
 2.6.15 rc1
Message-Id: <20060121010932.5d731f90.akpm@osdl.org>
In-Reply-To: <20060120123202.GA1138@epio.fluido.as>
References: <20060120123202.GA1138@epio.fluido.as>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Carlo E. Prelz" <fluido@fluido.as> wrote:
>
> Best regards to all and everyone. I just purchased a new RS480 (Radeon
>  XPress200)-based motherboard. It is a Sapphire Pure Performance
>  PP-A9RS480. Mine is equipped with an Athlon64 3200+. I am attaching
>  the output of lspci -v
> 
>  When booting with kernels from 2.6.15-rc1 up (tested with 2.6.15-rc1,
>  2.6.15-rc5, 2.6.15 and 2.6.16-rc1), the boot process freezes after
>  displaying messages retated to registering io schedulers:
> 
>  ...
>  ...
>  io scheduler noop registered
>  io scheduler anticipatory registered
>  io scheduler deadline registered
>  io scheduler cfq registered
> 
>  There is no OOPS of any kind. The disk activity led remains on. With
>  both 2.6.14 and 2.6.14.6, boot regularly continues with:
> 
>  Floppy drive(s): fd0 is 1.44M
>  FDC 0 is a post-1991 82077
>  loop: loaded (max 8 devices)
>  pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
>  nbd: registered device at major 43
>  ...
>  ...
> 
>  I tried to enable all debug options in configure, but no new message
>  appears. 
> 
>  Important: I obtain the same result (frozen after "io scheduler cfq
>  registered") when booting with a 100MB netinst debian sid bootdisk,
>  downloaded last night. An older (9 month old) Ubuntu bootdisk boots
>  perfectly. Both cd's are AMD64-specific.
> 

Can you please add `initcall_debug' to the kernel boot command line? 
That'll tell us which function got stuck.

