Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315440AbSHRRqs>; Sun, 18 Aug 2002 13:46:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315442AbSHRRqs>; Sun, 18 Aug 2002 13:46:48 -0400
Received: from mail.coastside.net ([207.213.212.6]:7885 "EHLO
	mail.coastside.net") by vger.kernel.org with ESMTP
	id <S315440AbSHRRqr>; Sun, 18 Aug 2002 13:46:47 -0400
Mime-Version: 1.0
Message-Id: <p05111a2bb9858e64756e@[207.213.214.37]>
In-Reply-To: <1029655603.2970.6.camel@psuedomode>
References: <1029653085.674.53.camel@psuedomode>
 <1029655603.2970.6.camel@psuedomode>
Date: Sun, 18 Aug 2002 10:50:41 -0700
To: Ed Sweetman <safemode@speakeasy.net>, linux-kernel@vger.kernel.org
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: cerberus errors on 2.4.19 (ide dma related)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 3:26 AM -0400 8/18/02, Ed Sweetman wrote:
>It appears then that there are some DMA issues with the promise 
>controller i have with the driver.  My swap used to be on the drive 
>on the promise controller before which would explain fs corruption 
>on both drives (swap cached and such).

FWIW, this is a semi-well-known phenomenon with the IDE controller in 
the ServerWorks OSB4 south bridge. As I recall from our testing, a 
word appears to be dropped in the DMA transfer to the disk. We found 
that both PIO and multi-word DMA worked OK.

What's your chipset?
-- 
/Jonathan Lundell.
