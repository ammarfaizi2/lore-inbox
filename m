Return-Path: <linux-kernel-owner+w=401wt.eu-S965085AbXAJUeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbXAJUeJ (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 15:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965088AbXAJUeJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 15:34:09 -0500
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:40425 "EHLO
	smtp.drzeus.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965085AbXAJUeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 15:34:08 -0500
Message-ID: <45A54DC7.4060403@drzeus.cx>
Date: Wed, 10 Jan 2007 21:34:15 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.9 (X11/20061223)
MIME-Version: 1.0
To: pierre Tardy <tardyp@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [RFC] New MMC driver model
References: <449553E5.9030004@drzeus.cx> <loom.20070109T150821-717@post.gmane.org>
In-Reply-To: <loom.20070109T150821-717@post.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please keep me as cc as I will almost always overlook you replies
otherwise)

pierre Tardy wrote:
> Pierre Ossman <drzeus-list <at> drzeus.cx> writes:
> 
>> Register functions
>> ==================
>>
>> I also intend to write a couple of register functions (sdio_read[bwl])
>> so that card drivers doesn't have to deal with MMC requests more than
>> necessary.
> 
> Good idea. Another need may be a sdio_read[bwl]_sync, which will poll for the
> end of the cmd52s, instead of waiting for the irq. This polling is faster than
> wait_for_completion/irq/tasklet/complete mechanism, which involve several
> context switches. 
> 

Hadn't thought of that. I will have to do some tests once I have
something functional.

>>  Endianness can also be handled there (SDIO are always LE).
> I dont remember sdio spec forcing HW registers to be LE. Function 0 registers
> are (BLKSZ for ex), but Function 1-7 register may be BE if the designers found
> an advantage to it..
> 

Hmm... It's been a while since I read the spec, but perhaps the LE
requirement was only for the base registers.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org
