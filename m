Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129143AbRA3Elm>; Mon, 29 Jan 2001 23:41:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129274AbRA3Eld>; Mon, 29 Jan 2001 23:41:33 -0500
Received: from mlx3.unm.edu ([129.24.8.189]:24434 "HELO mlx3.unm.edu")
	by vger.kernel.org with SMTP id <S129143AbRA3ElX>;
	Mon, 29 Jan 2001 23:41:23 -0500
Date: Mon, 29 Jan 2001 21:41:21 -0700 (MST)
From: Todd <todd@unm.edu>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Dolphin PCI-SCI RPM Drivers 1.1-4 released
In-Reply-To: <20010129164953.A15219@vger.timpanogas.org>
Message-ID: <Pine.A41.4.31.0101292123270.54650-100000@aix06.unm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

folx,

i must be missing something here.  i'm not aware of a PCI bus that only
supports 70 MBps but i am probably ignorant.  this is why i was confused
by jeff's performance numbers.  33MHz 32-bit PCI busses should do around
120MB/s (just do the math 33*32/8 allowing for some overhead of PCI bus
negotiation), much greater than the numbers jeff is reporting.  66 MHz
64bit busses should do on the order of 500MB/s.

the performance numbers that jeff is reporting are not very impressive
even for the slowest PCI bus.  we're seeing 993 Mbps (124MB/s) using the
alteon acenic gig-e cards on 32-bit cards on a 66MHz bus.  i would expect
to get somewhat slower on a 33MHz bus but not catastrophically so
(certainly nothing as slow as 60MB/s or 480Mb/s).

what am i misunderstanding here?

todd

On Mon, 29 Jan 2001, Jeff V. Merkey wrote:

> Date: Mon, 29 Jan 2001 16:49:53 -0700
> From: Jeff V. Merkey <jmerkey@vger.timpanogas.org>
> To: linux-kernel@vger.kernel.org
> Cc: jmerkey@timpanogas.org
> Subject: Re: [ANNOUNCE] Dolphin PCI-SCI RPM Drivers 1.1-4 released
>
>
> Relative to some performance questions folks have asked, the SCI
> adapters are limited by PCI bus speeds.  If your system supports
> 64-bit PCI you get much higher numbers.  If you have a system
> that supports 100+ Megabyte/second PCI throughput, the SCI
> adapters will exploit it.
>
> This test was performed in on a 32-bit PCI system with a PCI bus
> architecture that's limited to 70 MB/S.
>
> Jeff
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> Please read the FAQ at http://www.tux.org/lkml/
>

=========================================================
Todd Underwood, todd@unm.edu

criticaltv.com
news, analysis and criticism.  about tv.
and other stuff.

=========================================================

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
