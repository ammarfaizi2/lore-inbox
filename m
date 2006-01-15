Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751914AbWAOMP2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751914AbWAOMP2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 07:15:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751915AbWAOMP2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 07:15:28 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:48770 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751914AbWAOMP2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 07:15:28 -0500
Date: Sun, 15 Jan 2006 13:15:23 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Thomas Fazekas <thomas.fazekas@gmail.com>
cc: linux-kernel@vger.kernel.org, arch@archlinux.org
Subject: Re: Modify setterm color palette
In-Reply-To: <421547be0601150407v8e087afh55a9ee12ae27ac8e@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0601151313360.4174@yvahk01.tjqt.qr>
References: <421547be0601150407v8e087afh55a9ee12ae27ac8e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I've been looking in the kernel sources in the "console.c" and I think
>spotted the
>place where the colours are set but it seems to me that a more appropiate
>place to do such things would be the terminfo db.
>
>Any hints ?

drivers/char/vt.c: default_red, default_grn, default_blu

You can also change them with `echo -en "\e]PXRRGGBB"`, where X is a hex 
digit (range 0-F), and RGB are the components. Check console_codes(4) and 
go figure. :)

>I'm using radeonfb under Suse/amd64 if that makes any difference...

I am not sure if changing colors works with fb, try your best.



Jan Engelhardt
-- 
