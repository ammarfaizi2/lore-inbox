Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbUC1Tfg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 14:35:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262389AbUC1Tfg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 14:35:36 -0500
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:62405 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S262388AbUC1Tff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 14:35:35 -0500
Date: Sun, 28 Mar 2004 14:35:44 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Glenn Johnson <glennpj@charter.net>
Cc: Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-rc2-mm[34] causes drop in DRI FPS
In-Reply-To: <1080492821.7578.5.camel@gforce.johnson.home>
Message-ID: <Pine.LNX.4.58.0403281434010.19857@montezuma.fsmlabs.com>
References: <1080435375.8280.1.camel@gforce.johnson.home> 
 <20040327180932.10e4bae7.akpm@osdl.org>  <1080443802.7085.2.camel@gforce.johnson.home>
  <20040328090637.GA11056@elte.hu>  <1080490657.9667.7.camel@gforce.johnson.home>
 <1080492821.7578.5.camel@gforce.johnson.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 28 Mar 2004, Glenn Johnson wrote:

> I just did a diff of my XFree86 log files with the system booted using
> the 2.6.5-rc2-mm2 and 2.6.5-rc2-mm4 kernels, respectively. Here is the
> diff, so maybe this will mean something.
>
> --- XFree86-2.6.5-rc2-mm2.log	2004-03-28 10:32:00.070254034 -0600
> +++ XFree86-2.6.5-rc2-mm4.log	2004-03-28 10:29:30.123163884 -0600
> @@ -19 +19 @@
> -(==) Log file: "/var/log/XFree86.0.log", Time: Sun Mar 28 10:31:22 2004
> +(==) Log file: "/var/log/XFree86.0.log", Time: Sun Mar 28 10:28:32 2004
> @@ -713,2 +713,2 @@
> -(II) RADEON(0): [drm] added 8192 byte SAREA at 0xe188b000
> -(II) RADEON(0): [drm] mapped SAREA 0xe188b000 to 0x48328000
> +(II) RADEON(0): [drm] added 8192 byte SAREA at 0xe1889000
> +(II) RADEON(0): [drm] mapped SAREA 0xe1889000 to 0x48328000

That's just a memory allocation, so that will never be consistent.

> @@ -764 +764 @@
> -(II) RADEON(0): [drm] dma control initialized, using IRQ 169
> +(II) RADEON(0): [drm] dma control initialized, using IRQ 10

You're not using CONFIG_PCI_USE_VECTOR in the newer kernel, but that also
wouldn't make a difference.
