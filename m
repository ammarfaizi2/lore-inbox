Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130842AbRAWNLR>; Tue, 23 Jan 2001 08:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130460AbRAWNK5>; Tue, 23 Jan 2001 08:10:57 -0500
Received: from mailhub2.shef.ac.uk ([143.167.2.154]:7845 "EHLO
	mailhub2.shef.ac.uk") by vger.kernel.org with ESMTP
	id <S130673AbRAWNK4>; Tue, 23 Jan 2001 08:10:56 -0500
Newsgroups: comp.os.linux.setup,comp.os.linux.hardware,comp.os.linux.development.system
Date: Tue, 23 Jan 2001 13:09:14 +0000 (GMT)
From: "Guennadi V. Liakhovetski" <G.Liakhovetski@sheffield.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: DMA vs PIO speeds...
Message-ID: <Pine.GSO.4.21.0101231240010.19780-100000@acms23>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everybody

With the help from Andre Hedrick and others and by a horrible dirty hack
in ide-dma.c I managed to enable DMA for a weird (rare?) revision of
Triton chipset in 2.4.1-pre8 kernel (last kernel, when DMA worked for this
chipset was 2.0.39). So, now I've got PIO4 (max throughput 16.6 
MB/sec) and DMA mword2 (also 16.6 MB/sec). Here goes the weird thing:
hdparm -t /dev/hda
with PIO4    - 4.1 MB/sec (4.8 with 2.2.x kernels)
with DMA mw2 - 3.1 MB/sec

I understand I won't be able to change this, but a purely theoretical
question - why? And, can there be (extremely rare on a standalone home
machine) occasions, say, when you need both the CPU and hd IO, when DMA
3.1 would outperform PIO 4.1 (or even 4.8)? I am going to try bonnie
too...

Thanks
Guennadi
___

Dr. Guennadi V. Liakhovetski
Department of Applied Mathematics
University of Sheffield, U.K.
email: G.Liakhovetski@sheffield.ac.uk



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
