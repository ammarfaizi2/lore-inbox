Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270558AbRHNLBa>; Tue, 14 Aug 2001 07:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270562AbRHNLBT>; Tue, 14 Aug 2001 07:01:19 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:36367 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S270558AbRHNLBC>; Tue, 14 Aug 2001 07:01:02 -0400
Subject: Re: module agpgart in 2.4.7
To: wicki@terror.de (Victoria W.)
Date: Tue, 14 Aug 2001 12:03:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10108141022000.4218-100000@csb.terror.de> from "Victoria W." at Aug 14, 2001 10:30:58 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15WbyZ-0000vr-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm not shure, if this is the right place for this question, but I'll try
> it.
> On a new mini-pc "lspci" shows the following:
> 
> 00:01.0 Class 0300: 8086:7125 (rev 03)
> or
> 00:01.0 VGA compatible controller: Intel Corporation: Unknown device 7125
> (rev 03)
> 
> I have complied the agpgart-module with intel-support, but "insmod
> agpgart" results in:
> Is there a driver availiable, which supports this chipset?

One way to find out.

	modprobe agp agp_try_unsupported=1

That will try treating your unknown chipset as if it were the same as the
other intel ones. If it works let me know 
