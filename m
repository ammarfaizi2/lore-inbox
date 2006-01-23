Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbWAWCOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbWAWCOy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 21:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWAWCOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 21:14:53 -0500
Received: from sccrmhc12.comcast.net ([63.240.77.82]:33460 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751387AbWAWCOw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 21:14:52 -0500
Date: Sun, 22 Jan 2006 21:14:40 -0500 (EST)
From: Ariel <askernel2615@dsgml.com>
To: Arjan van de Ven <arjan@infradead.org>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: memory leak in scsi_cmd_cache 2.6.15
In-Reply-To: <1137956841.3328.36.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.62.0601222045180.12815@pureeloreel.qftzy.pbz>
References: <Pine.LNX.4.62.0601212105590.22868@pureeloreel.qftzy.pbz> 
 <1137917798.3328.2.camel@laptopd505.fenrus.org>  <1137918044.3328.6.camel@laptopd505.fenrus.org>
  <Pine.LNX.4.62.0601221251340.30208@pureeloreel.qftzy.pbz>
 <1137956841.3328.36.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Jan 2006, Arjan van de Ven wrote:
>>> On Sun, 2006-01-22 at 09:16 +0100, Arjan van de Ven wrote:
>>>> On Sat, 2006-01-21 at 21:13 -0500, Ariel wrote:

>>>>> I have a memory leak in scsi_cmd_cache.

>>>> does this happen without the binary nvidia driver too? (it appears
>>>> you're using that). That's a good datapoint to have if so...

> please repeat this without nvidia ever being loaded. Just having a
> module loaded before can already cause corruption that ripples through
> later, so just unloading is not enough to get a clean result.

I rebooted without nvidia or vmware ever being loaded and got a 
leak of 1.12KB/s. So I think we can rule that out.

A commonality I'm noticing is SATA. SATA had a big update in this 
version, so perhaps that's where to start looking.

 	-Ariel
