Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269120AbTGUA1z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 20:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269124AbTGUA1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 20:27:54 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:58896 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S269120AbTGUA1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 20:27:53 -0400
Date: Mon, 21 Jul 2003 02:42:52 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: schierlm@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test1 and LILO problem: "Device 0x0300: Invalid partition table, 1st entry"
Message-ID: <20030721024252.A11485@pclin040.win.tue.nl>
References: <S268256AbTGTXnW/20030720234322Z+3835@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <S268256AbTGTXnW/20030720234322Z+3835@vger.kernel.org>; from schierlm-usenet@gmx.de on Mon, Jul 21, 2003 at 01:57:53AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 21, 2003 at 01:57:53AM +0200, Michael Schierl wrote:

> I installed 2.6.0-test1 kernel on my acer laptop. Seems to run quite
> well (even APM works now), but when I try to rerun LILO (when I
> recompiled the kernel), it does not work on 2.6.0-test1 kernel:
> 
> ---
> LILO version 22.2, Copyright (C) 1992-1998 Werner Almesberger
> Development beyond version 21 Copyright (C) 1999-2001 John Coffman
> Released 05-Feb-2002 and compiled at 20:57:26 on Apr 13 2002.
...
> Boot other: /dev/hda1, on /dev/hda, loader /boot/chain.b
> Device 0x0300: Invalid partition table, 1st entry
>   3D address:     1/1/261 (263151)
>   Linear address: 1/12/4159 (4193028)
...
> looking at /proc/ide/hda/geometry reveals on 2.4.20:
> 
> ---
> physical     19485/16/63
> logical      1222/255/63
> ---
> 
> on 2.6.0-test1:
> 
> ---
> physical     19485/16/63
> logical      19485/16/63
> ---

I think the easiest answer is: get a more recent LILO.
(And make sure to use linear or lba32 or so.)

