Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267738AbTAIVoF>; Thu, 9 Jan 2003 16:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267749AbTAIVoF>; Thu, 9 Jan 2003 16:44:05 -0500
Received: from 216-239-45-4.google.com ([216.239.45.4]:39078 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id <S267738AbTAIVoF>; Thu, 9 Jan 2003 16:44:05 -0500
Message-ID: <3E1DEF29.8020900@google.com>
Date: Thu, 09 Jan 2003 13:52:41 -0800
From: Ross Biro <rossb@google.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: James Curbo <phoenix@sandwich.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: DMA timeouts on Promise 20267 IDE card
References: <20030109204350.GA413@carthage>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Curbo wrote:

>[please cc: me as I am not subscribed to lkml]
>
>I've recently started getting errors like this (this example is from
>2.4.20-pre3-ac2):
>
>Jan  9 14:20:48 carthage kernel: hda: dma_timer_expiry: dma status ==
>0x61
>Jan  9 14:20:48 carthage kernel: hdc: dma_timer_expiry: dma status ==
>0x21
>  
>
I believe the low bit set in the dma_status means that the DMA transfer 
is still in progress.  Since the timer has expired, that means it's been 
in progress for 10 seconds.  Odds are the drive has stopped responding. 
 Since it's a Western Digital drive, it probably needs to be powercycled 
to come back.

I don't think this is a problem with the controller card, but I could be 
wrong.

    Ross



