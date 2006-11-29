Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758796AbWK2Ep5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758796AbWK2Ep5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 23:45:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758798AbWK2Ep5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 23:45:57 -0500
Received: from mail6.sea5.speakeasy.net ([69.17.117.8]:9881 "EHLO
	mail6.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1758796AbWK2Ep4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 23:45:56 -0500
Date: Tue, 28 Nov 2006 20:45:56 -0800 (PST)
From: Trent Piepho <xyzzy@speakeasy.org>
X-X-Sender: xyzzy@shell2.speakeasy.net
To: Adrian Bunk <bunk@stusta.de>
cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] remove DVB_AV7110_FIRMWARE
In-Reply-To: <20061129030629.GD15364@stusta.de>
Message-ID: <Pine.LNX.4.58.0611282045040.28220@shell2.speakeasy.net>
References: <20061126004500.GB15364@stusta.de> <Pine.LNX.4.58.0611281304180.5546@shell3.speakeasy.net>
 <20061129030629.GD15364@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Nov 2006, Adrian Bunk wrote:
> On Tue, Nov 28, 2006 at 01:06:02PM -0800, Trent Piepho wrote:
> > On Sun, 26 Nov 2006, Adrian Bunk wrote:
> > > DVB_AV7110_FIRMWARE was (except for some OSS drivers) the only option
> > > that was still compiling a binary-only user-supplied firmware file at
> > > build-time into the kernel.
> > >
> > > This patch changes the driver to always use the standard
> > > request_firmware() way for firmware by removing DVB_AV7110_FIRMWARE.
> >
> > Doesn't this also prevent the AV7110 module from getting compiled
> > into the kernel?  Shouldn't the Kconfig file be adjusted so
> > that 'y' can't be selected anymore and it depends on MODULES?
>
> No.
> No.
>
> request_firmware() works fine for built-in drivers.

Wouldn't that require loading the firmware file before the filesystems are
mounted?
