Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315851AbSEQMbn>; Fri, 17 May 2002 08:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315374AbSEQMah>; Fri, 17 May 2002 08:30:37 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:49674 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S315835AbSEQMaH>; Fri, 17 May 2002 08:30:07 -0400
Subject: Re: Process priority in 2.4.18 (RedHat 7.3)
To: akpm@zip.com.au (Andrew Morton)
Date: Fri, 17 May 2002 13:49:21 +0100 (BST)
Cc: paul@engsoc.org (Paul Faure), andrea@suse.de (Andrea Arcangeli),
        linux-kernel@vger.kernel.org
In-Reply-To: <3CE46914.F4547F16@zip.com.au> from "Andrew Morton" at May 16, 2002 07:21:08 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E178hAf-0006PS-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So the problem would appear to be that your networking *requires*
> ksoftirqd services to function.  Either:
> 
> 1) The driver is bust - its hard_start_xmit() function is failing
>    frequently, and relying on ksoftirqd to get things done (I think;
>    it's been a while).  Or

The ne2k card has little buffering. 

> 2) Something is wrong with the ksoftirqd design.  Or

I think its mostly #2. We invoke ksoftirq far far too easily.
