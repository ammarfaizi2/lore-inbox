Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264833AbTFWQMR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 12:12:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264908AbTFWQMR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 12:12:17 -0400
Received: from RJ088138.user.veloxzone.com.br ([200.141.88.138]:21639 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id S264833AbTFWQKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 12:10:32 -0400
Date: Mon, 23 Jun 2003 13:24:37 -0300 (BRT)
From: =?UTF-8?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <0@pervalidus.tk>
X-X-Sender: fredlwm@pervalidus.dyndns.org
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21: Reproduceable Oops doing modprobe bttv (ProLink PixelView
 PlayTVpro 9D)
Message-ID: <Pine.LNX.4.56.0306231315510.181@pervalidus.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.20 worked fine with bttv-0.7.106.tar.gz. Today I used
> 2.4.21 with the kernel modules and got a reproduceable Oops
> doing modprobe bttv. lsmod shows bttv as (initializing).

It seems to be caused by the incompatibilities with I2C 2.8.0:

"ADDITIONALLY, i2c-2.8.0 is not API compatible to earlier i2c
releases due to struct changes; therefore you must NOT ENABLE
any other i2c drivers (e.g. bttv) in the kernel.  Do NOT use
lm-sensors 2.8.0 or i2c-2.8.0 if you require bttv."
