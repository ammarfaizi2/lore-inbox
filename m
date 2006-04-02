Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932318AbWDBKz0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWDBKz0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 06:55:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWDBKz0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 06:55:26 -0400
Received: from khc.piap.pl ([195.187.100.11]:42255 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S932314AbWDBKzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 06:55:25 -0400
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: IDE CDROM tail read errors
References: <m3wtedrrpf.fsf@defiant.localdomain>
	<Pine.LNX.4.61.0603301016290.30783@yvahk01.tjqt.qr>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 02 Apr 2006 12:55:23 +0200
In-Reply-To: <Pine.LNX.4.61.0603301016290.30783@yvahk01.tjqt.qr> (Jan Engelhardt's message of "Thu, 30 Mar 2006 10:19:48 +0200 (MEST)")
Message-ID: <m3hd5ctffo.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> writes:

>>first: 1 last 1
>>track:   1 lba:         0 (        0) 00:02:00 adr: 1 control: 4 mode: 1
>>track:lout lba:    335566 (  1342264) 74:36:16 adr: 1 control: 4 mode: -1
>>
>>FC-5-i386-disc1.iso size = 335564 * 2048 bytes, not sure why TOC has
>>2 more sectors (8 512B sectors) but I'm not a CD expert.
>>
>
> I have heard from friends that this is due to how readahead works. It 
> reads beyond the end of the track, and logically, the hardware signals an 
> error (leading to missing bytes at the end). It is said to be solved using 
> the -pad option when writing CDs.

You mean the read error and not TOC <> .iso track length differences?
-- 
Krzysztof Halasa
