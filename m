Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131348AbRDQUAN>; Tue, 17 Apr 2001 16:00:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132570AbRDQUAE>; Tue, 17 Apr 2001 16:00:04 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:15633 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131348AbRDQT7w>; Tue, 17 Apr 2001 15:59:52 -0400
Subject: Re: why raw devices don't seek above 4GB (sometimes)
To: k.lichtenwalder@computer.org
Date: Tue, 17 Apr 2001 21:01:24 +0100 (BST)
Cc: xine-user@lists.sourceforge.net (xine discussion list),
        linux-kernel@vger.kernel.org
In-Reply-To: <3ADC90EB.526BF2FF@computer.org> from "k.lichtenwalder@computer.org" at Apr 17, 2001 08:52:27 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14pbfD-00036X-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I set up a raw device: raw /dev/raw/raw1 /dev/hdd
> with /dev/hdd being my DVD drive.
> Xine then does repeated llseeks on /dev/raw/raw1 until it gets above 4G.
> Because /dev/raw/raw1 and the associated /dev/hdd both are on reiserfs,
> and reiserfs has a 4G limit, llseek assumes the same for the associated
> raw devices and returns from the llseek with EINVAL. Bang. 
> I don't know whether there's an easy solution. 

That sounds like /dev/raw/.. should have its own lseek method.

Alan

