Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263523AbUACPsG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 10:48:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263539AbUACPsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 10:48:06 -0500
Received: from smtp.netcabo.pt ([212.113.174.9]:47425 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S263523AbUACPsC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 10:48:02 -0500
From: Marco Correia <mvc@netcabo.pt>
To: linux-kernel@vger.kernel.org
Subject: why is rdtsc reporting wrong cpu cycles?
Date: Sat, 3 Jan 2004 15:48:39 +0000
User-Agent: KMail/1.5.3
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401031548.40025.mvc@netcabo.pt>
X-OriginalArrivalTime: 03 Jan 2004 15:47:57.0524 (UTC) FILETIME=[F56AE940:01C3D210]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using the following function for getting the number of CPU cycles elapsed 
since I rebooted:

/* Read Timer Stamp Counter */
unsigned long long int rdtsc(void)
{
   unsigned long long int x;

   __asm__ volatile(".byte 0x0f,0x31" : "=A" (x));
   return x;
}

The problem is that the value I get dividing by my processor frequency (my 
computer is a 650Mhz toshiba satellite pro 4340) is giving me about 1 hour 
and I'm using the computer for about 4 fours.

Am I forgetting something obvious? I already googled around but I came to the 
conclusion that only new P4 M processors are able to change speed. 

I'm sorry if this is not the place to ask.

Thanks
Marco

ps: Please CC me as I'm not subscribed

-- 
Marco Correia <mvc@netcabo.pt>

