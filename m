Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVGVJfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVGVJfD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 05:35:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261537AbVGVJfC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 05:35:02 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:19128 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261513AbVGVJe6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 05:34:58 -0400
Date: Fri, 22 Jul 2005 11:34:55 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: sampei02@tiscali.it
cc: linux-kernel@vger.kernel.org
Subject: Re: DriveStatusError BadCRC
In-Reply-To: <42D7AA0C000141C7@mail-8.mail.tiscali.sys>
Message-ID: <Pine.LNX.4.61.0507221133180.11709@yvahk01.tjqt.qr>
References: <42D7AA0C000141C7@mail-8.mail.tiscali.sys>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I bought new Maxtor HD 80 GB but somthing Fedora Core 3 crashes giving this
>message:
>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }
>ide: failed opcode was: unknown
>hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>hda: dma_intr: Error=0x84 { DriveStatusError BadCRC }
>ide: failed opcode was: unknown

Does this happen on boot?

Check your harddrive... smartctl -data -a /dev/hda and look for 
199 UDMA_CRC_Error_Count    0x0008   198   193   000    Old_age   Offline      -
and
  Commands leading to the command that caused the error were:
  CR FR SC SN CL CH DH DC   Powered_Up_Time  Command/Feature_Name
  -- -- -- -- -- -- -- --  ----------------  --------------------
  c8 00 38 2f 8f 07 e4 08  43d+13:12:02.304  READ DMA



Jan Engelhardt
-- 
