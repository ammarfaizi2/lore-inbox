Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266509AbUBQTLl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 14:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266494AbUBQTLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 14:11:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:30436 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266509AbUBQTJt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 14:09:49 -0500
Date: Tue, 17 Feb 2004 11:09:45 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: GCS <gcs@lsc.hu>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.3-rc4
In-Reply-To: <20040217184543.GA18495@lsc.hu>
Message-ID: <Pine.LNX.4.58.0402171107040.2154@home.osdl.org>
References: <Pine.LNX.4.58.0402161945540.30742@home.osdl.org>
 <20040217184543.GA18495@lsc.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 17 Feb 2004, GCS wrote:
>
> drivers/built-in.o(.text+0xb2c44): In function `radeon_do_probe_i2c_edid':
> : undefined reference to `i2c_transfer'
> make: *** [.tmp_vmlinux1] Error 1
> 
> .config snippshet:
> # CONFIG_FB_RADEON_OLD is not set
> CONFIG_FB_RADEON=y
> CONFIG_FB_RADEON_I2C=y
> CONFIG_FB_RADEON_DEBUG=y

I don't see this. What's your I2C config, and how did you generate your 
config file?

CONFIG_FB_RADEON_I2C should depend on CONFIG_I2C, and it selects 
I2C_ALGOBIT, but your error messages seem to imply that you don't have i2c 
enabled at all.

Which implies a configuration error (but the Kconfig file looks correct, 
so I wonder if you found a bug in the configurator).

		Linus
