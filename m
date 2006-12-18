Return-Path: <linux-kernel-owner+w=401wt.eu-S1754397AbWLRTAV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754397AbWLRTAV (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 14:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754400AbWLRTAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 14:00:21 -0500
Received: from wr-out-0506.google.com ([64.233.184.227]:19886 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397AbWLRTAU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 14:00:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PHonvb+U1RB7/1wwSrZY9NdR1jjocF22njbVLuR+z5B+pGAm2hFDbNtU9cWs1OZ2gxDyhQf3jnoiuQqtjzvpjnCazDry15CpDUCaepinyzCoT06YuvGsFLhUMX7junnIPfGwIF1lFPuBEL8rWxo2cOdpBsDZAVggIpilbZaIuLM=
Message-ID: <a44ae5cd0612181100x2908bb7co2a6348653015f32@mail.gmail.com>
Date: Mon, 18 Dec 2006 11:00:16 -0800
From: "Miles Lane" <miles.lane@gmail.com>
To: "Jiri Slaby" <jirislaby@gmail.com>
Subject: Re: 2.6.20-rc1-mm1 -- WARNING (1) at arch/i386/mm/highmem.c:41 kmap_atomic()
Cc: "Andrew Morton" <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <4586E11E.6040706@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <a44ae5cd0612180948g75da787ge2cf47f2208f7741@mail.gmail.com>
	 <4586E11E.6040706@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/18/06, Jiri Slaby <jirislaby@gmail.com> wrote:
> Miles Lane wrote:
> > Sorry, I am not finding who maintains highmem.  Please forward.
> >
> > WARNING (1) at arch/i386/mm/highmem.c:41 kmap_atomic()
> > [<c0103c25>] dump_trace+0x68/0x1d2
> > [<c0103da7>] show_trace_log_lvl+0x18/0x2c
> > [<c0104410>] show_trace+0xf/0x11
> > [<c010449b>] dump_stack+0x12/0x14
> > [<c01144d9>] kmap_atomic+0x6f/0x1ca
> > [<f930e25d>] ntfs_end_buffer_async_read+0x25d/0x2ca [ntfs]
> > [<c017c294>] end_bio_bh_io_sync+0x2c/0x37
> > [<c017dc29>] bio_endio+0x5a/0x62
> > [<c01c8412>] __end_that_request_first+0x145/0x3ab
> > [<c0237695>] ide_end_request+0x80/0xd8
> > [<c023e3f0>] ide_dma_intr+0x55/0x9a
> > [<c02388dc>] ide_intr+0x182/0x1f2
> > [<c0140775>] handle_IRQ_event+0x1a/0x3f
> > [<c0141baa>] handle_edge_irq+0xc6/0x11c
> > [<c0105416>] do_IRQ+0x57/0x71
> > [<c010366b>] common_interrupt+0x23/0x28
> > [<f8826ee4>] acpi_processor_idle+0x1cc/0x36c [processor]
> > [<c010132b>] cpu_idle+0x3e/0x6c
> > [<c03f06d9>] start_kernel+0x2fa/0x2fe
> > =======================
>
> Reported yet, you might see it here:
> http://lkml.org/lkml/2006/12/15/222

It is certainly very similar, and probably has the same root cause.
Though, the trace isn't an exact match.   So, who should look into
this?

Thanks,
         Miles
