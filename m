Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932101AbWC3IUA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932101AbWC3IUA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 03:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932111AbWC3IT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 03:19:58 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32902 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932101AbWC3ITv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 03:19:51 -0500
Date: Thu, 30 Mar 2006 10:19:48 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
Subject: Re: IDE CDROM tail read errors
In-Reply-To: <m3wtedrrpf.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.61.0603301016290.30783@yvahk01.tjqt.qr>
References: <m3wtedrrpf.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
># cdrecord -toc
>
>first: 1 last 1
>track:   1 lba:         0 (        0) 00:02:00 adr: 1 control: 4 mode: 1
>track:lout lba:    335566 (  1342264) 74:36:16 adr: 1 control: 4 mode: -1
>
>FC-5-i386-disc1.iso size = 335564 * 2048 bytes, not sure why TOC has
>2 more sectors (8 512B sectors) but I'm not a CD expert.
>

I have heard from friends that this is due to how readahead works. It 
reads beyond the end of the track, and logically, the hardware signals an 
error (leading to missing bytes at the end). It is said to be solved using 
the -pad option when writing CDs.

^^ I could not reproduce this oddness on my own, though.
Just a hint, maybe.


Jan Engelhardt
-- 
