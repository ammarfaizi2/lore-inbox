Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261708AbVCSTRN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261708AbVCSTRN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Mar 2005 14:17:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVCSTRN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Mar 2005 14:17:13 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:56514 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261708AbVCSTRJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Mar 2005 14:17:09 -0500
Date: Sat, 19 Mar 2005 20:17:03 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Baruch Even <baruch@ev-en.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Relayfs question
In-Reply-To: <423C78E8.3040200@ev-en.org>
Message-ID: <Pine.LNX.4.61.0503192014520.14144@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503191852520.21324@yvahk01.tjqt.qr>
 <423C78E8.3040200@ev-en.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>[...]
> The current method is to just manage buffers and enable applications to mmap
> the buffers to read them with some signalling on when a buffer is to be read
> and when the kernel can overwrite it.
>
> A character device is unlikely to need such interface since you do want 16
> bytes of random data and not several pages of mapped random numbers. If you
> really need a lot of random numbers you need something in user-space anyway
> since you'll deplete the kernel entropy pool pretty fast anyway.
>
> If you have a device that needs to transfer lots of data doesn't mind it being
> batched and doesn't really need the character device interface then relayfs
> could be useful.

Ok, urandom was a bad example. I have my tty logger (ttyrpld.sf.net) which 
moves a lot of data (depends) to userspace. It uses a ring buffer of "fixed" 
size (set at module load time). Apart from that relayfs could use a dynamic 
sized ring buffer, I would not see any need to move it to relayfs, would you?



Jan Engelhardt
-- 
