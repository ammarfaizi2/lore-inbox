Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268908AbRIDUPP>; Tue, 4 Sep 2001 16:15:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268901AbRIDUO4>; Tue, 4 Sep 2001 16:14:56 -0400
Received: from gnu.in-berlin.de ([192.109.42.4]:38660 "EHLO gnu.in-berlin.de")
	by vger.kernel.org with ESMTP id <S268916AbRIDUOr>;
	Tue, 4 Sep 2001 16:14:47 -0400
X-Envelope-From: news@bytesex.org
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Gerd Knorr <kraxel@bytesex.org>
Newsgroups: lists.linux.kernel
Subject: Re: DMA to/from user buffers
Date: 4 Sep 2001 19:30:49 GMT
Organization: SuSE Labs, =?ISO-8859-1?Q?Au=DFenstelle?= Berlin
Message-ID: <slrn9paav9.8bf.kraxel@bytesex.org>
In-Reply-To: <20010904164509.A27144@csr-pc1.zib.de>
NNTP-Posting-Host: localhost
X-Trace: bytesex.org 999631849 8560 127.0.0.1 (4 Sep 2001 19:30:49 GMT)
User-Agent: slrn/0.9.7.1 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Heidl wrote:
>  
>  Hi,
>  
>  two questions about using an user-supplied buffer (e.g. malloced
>  in user space) for DMA transfers:
>  
>  1. Is it possible ?
>  2. What restrictions/requirements apply for the buffer (alignment...) ?
>  
>  Documentation/DMA-mapping.txt only talks about buffers allocated in
>  kernel space.

Lock down the user pages using kiobufs (see include/linux/iobufs.h),
then feed these pages to the pci_* functions.

  Gerd

-- 
Damn lot people confuse usability and eye-candy.
