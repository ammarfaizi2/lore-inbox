Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUGOWU0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUGOWU0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 18:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266389AbUGOWU0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 18:20:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:36750 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266386AbUGOWUV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 18:20:21 -0400
Date: Thu, 15 Jul 2004 14:04:58 -0700
From: Andrew Morton <akpm@osdl.org>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Losing interrupts
Message-Id: <20040715140458.3c0aee37.akpm@osdl.org>
In-Reply-To: <1089927383.24832.14.camel@mindpipe>
References: <1089843559.22841.8.camel@mindpipe>
	<1089927383.24832.14.camel@mindpipe>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lee Revell <rlrevell@joe-job.com> wrote:
>
> There was an issue several years ago where Matrox figured out they could
> get slightly better benchmark scores by not checking whether a FIFO on
> the video card was full before writing to it, which would cause the PCI
> bus to completely freeze until the FIFO had drained.  Lots of vendors
> followed suit until one of the audio software vendors figred it out and
> called them on it, at which point they fixed their drivers.  The effects
> (massive audio drouputs) and the steps to reproduce (drag a window
> around the screen slowly) were identical.

There's an XF86Config incantation which is supposed to prevent this: if you
set it, the driver will poll the FIFO-full bit before actually reading the
FIFO.

hm, according to http://www.xfree86.org/3.3.6/3DLabs3.html, the pci_retry
option _causes_ the bad behaviour, rather than avoiding it.

Oh, well.  Have a play with that.
