Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265291AbTLaXqW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Dec 2003 18:46:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265292AbTLaXqW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Dec 2003 18:46:22 -0500
Received: from fw.osdl.org ([65.172.181.6]:7088 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265291AbTLaXqV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Dec 2003 18:46:21 -0500
Date: Wed, 31 Dec 2003 15:46:48 -0800
From: Andrew Morton <akpm@osdl.org>
To: Daniel McNeil <daniel@osdl.org>
Cc: suparna@in.ibm.com, janetmor@us.ibm.com, pbadari@us.ibm.com,
       linux-aio@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-2.6.1-rc1-mm1] aiodio_fallback_bio_count.patch
Message-Id: <20031231154648.2af81331.akpm@osdl.org>
In-Reply-To: <1072910475.712.74.camel@ibm-c.pdx.osdl.net>
References: <1070907814.707.2.camel@ibm-c.pdx.osdl.net>
	<1071190292.1937.13.camel@ibm-c.pdx.osdl.net>
	<1071624314.1826.12.camel@ibm-c.pdx.osdl.net>
	<20031216180319.6d9670e4.akpm@osdl.org>
	<20031231091828.GA4012@in.ibm.com>
	<20031231013521.79920efd.akpm@osdl.org>
	<20031231095503.GA4069@in.ibm.com>
	<20031231015913.34fc0176.akpm@osdl.org>
	<20031231100949.GA4099@in.ibm.com>
	<20031231021042.5975de04.akpm@osdl.org>
	<20031231104801.GB4099@in.ibm.com>
	<20031231025309.6bc8ca20.akpm@osdl.org>
	<20031231025410.699a3317.akpm@osdl.org>
	<20031231031736.0416808f.akpm@osdl.org>
	<1072910061.712.67.camel@ibm-c.pdx.osdl.net>
	<1072910475.712.74.camel@ibm-c.pdx.osdl.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel McNeil <daniel@osdl.org> wrote:
>
> This is an update of AIO fallback patch and with the bio_count race
>  fixed by changing bio_list_lock into bio_lock and using that for all
>  the bio fields.  I changed bio_count and bios_in_flight from atomics
>  into int.  They are now proctected by the bio_lock.  I fixed the race,
>  by in finished_one_bio() by leaving the bio_count at 1 until after the
>  dio_complete() and then do the bio_count decrement and wakeup holding
>  the bio_lock.

Sob.  Daniel, please assume that I have an extremely small brain and forget
things very easily.  And that 2,000 patches have passed under my nose since
last I contemplated the direct-io code, OK?

What bio_count race?

And the patch seems to be doing more than your description describes?
