Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129066AbRCBMim>; Fri, 2 Mar 2001 07:38:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129091AbRCBMic>; Fri, 2 Mar 2001 07:38:32 -0500
Received: from [62.172.234.2] ([62.172.234.2]:54060 "EHLO penguin.homenet")
	by vger.kernel.org with ESMTP id <S129066AbRCBMiO>;
	Fri, 2 Mar 2001 07:38:14 -0500
Date: Fri, 2 Mar 2001 12:35:50 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: José Luis Domingo López 
	<jldomingo@crosswinds.net>,
        linux-kernel@vger.kernel.org
Subject: cpu/bus speed detection (was Re: Linux 2.4.2ac7
In-Reply-To: <E14Ybjg-0000IG-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0103021231000.1338-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Alan Cox wrote:
> Please send me the value of your 0x2A MTRR. Because this isnt properly intel
> documented there is a certain amount of research still required.
> 

ok, adding this to init_intel():


        u32 lo, hi;

        rdmsr(0x2A, lo, hi);
        printk(KERN_ERR "lo=%x hi=%x\n", lo, hi);

produces the output:

# dmesg | grep lo=
lo=c5100800 hi=0
lo=c5100800 hi=0
lo=c5000800 hi=0

Tigran


