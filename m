Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261171AbVBGUto@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261171AbVBGUto (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Feb 2005 15:49:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVBGUto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Feb 2005 15:49:44 -0500
Received: from dns.toxicfilms.tv ([150.254.37.24]:36228 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S261171AbVBGUtl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Feb 2005 15:49:41 -0500
X-Qmail-Scanner-Toxic-Mail-From: solt2@dns.toxicfilms.tv via dns
X-Qmail-Scanner-Toxic-Rcpt-To: reiser@namesys.com,linux-kernel@vger.kernel.org
X-Qmail-Scanner-Toxic: 1.24st (Clear:RC:1(213.238.100.58):. Processed in 0.146998 secs Process 11570)
Date: Mon, 7 Feb 2005 21:59:57 +0100
From: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Mailer: The Bat! (v3.0.1.33) UNREG / CD5BF9353B3B7091
Reply-To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
X-Priority: 3 (Normal)
Message-ID: <1959057509.20050207215957@dns.toxicfilms.tv>
To: Hans Reiser <reiser@namesys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re[2]: 2.6.11-rc3-mm1 bad scheduling while atomic + lockup
In-Reply-To: <4207CD63.1080802@namesys.com>
References: <1865944987.20050207081532@dns.toxicfilms.tv>
 <4207CD63.1080802@namesys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Hans,

Monday, February 7, 2005, 9:19:47 PM, you wrote:

> Maciej Soltysiak wrote:

>>)
>>
>>Feb  6 17:07:47 dns kernel: hdc: dma_intr: status=0x51 { DriveReady SeekComplete Error }
>>Feb  6 17:07:47 dns kernel: hdc: dma_intr: error=0x84 { DriveStatusError BadCRC }
>>  
>>
> this means bad hard drive, or at least a bad sector on it.
Well, I have reiser4 on this drive with noncritical data which is rather
not used anyway.
But please note that, the process generating the oops (as long as I am
seeing this right) is something called swapper:

scheduling while atomic: swapper/0x00010001/0

My swap partition is not on hdc, it is on hda, which does not report
bad crc and any other dma related errors, or any for that matter.

The same machine runs on 2.6.10-ac10 + reiser-2.6.10 patch well or
at least it does not trigger these oopses.

Only some still not tracked down problems with terrible swap eating :-(
But that's a different story.

Regards,
Maciej


