Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755701AbWK1VGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755701AbWK1VGI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 16:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755735AbWK1VGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 16:06:07 -0500
Received: from mail5.sea5.speakeasy.net ([69.17.117.7]:28314 "EHLO
	mail5.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1755706AbWK1VGE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 16:06:04 -0500
Date: Tue, 28 Nov 2006 13:06:02 -0800 (PST)
From: Trent Piepho <xyzzy@speakeasy.org>
X-X-Sender: xyzzy@shell3.speakeasy.net
To: Adrian Bunk <bunk@stusta.de>
cc: v4l-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Subject: Re: [v4l-dvb-maintainer] [2.6 patch] remove DVB_AV7110_FIRMWARE
In-Reply-To: <20061126004500.GB15364@stusta.de>
Message-ID: <Pine.LNX.4.58.0611281304180.5546@shell3.speakeasy.net>
References: <20061126004500.GB15364@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2006, Adrian Bunk wrote:
> DVB_AV7110_FIRMWARE was (except for some OSS drivers) the only option
> that was still compiling a binary-only user-supplied firmware file at
> build-time into the kernel.
>
> This patch changes the driver to always use the standard
> request_firmware() way for firmware by removing DVB_AV7110_FIRMWARE.

Doesn't this also prevent the AV7110 module from getting compiled
into the kernel?  Shouldn't the Kconfig file be adjusted so
that 'y' can't be selected anymore and it depends on MODULES?
