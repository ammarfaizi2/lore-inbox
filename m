Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751363AbWERPVE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbWERPVE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 11:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWERPVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 11:21:04 -0400
Received: from onyx.ip.pt ([195.23.92.252]:49096 "EHLO mail.isp.novis.pt")
	by vger.kernel.org with ESMTP id S1751363AbWERPVD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 11:21:03 -0400
Subject: Re: [v4l-dvb-maintainer] [RFC: 2.6 patch]
	drivers/media/video/bt8xx/: possible cleanups
From: Ricardo Cerqueira <rmcc@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: mchehab@infradead.org, v4l-dvb-maintainer@linuxtv.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060516221729.GV10077@stusta.de>
References: <20060516221729.GV10077@stusta.de>
Content-Type: text/plain
Organization: video4linux
Date: Thu, 18 May 2006 16:21:01 +0100
Message-Id: <1147965661.5418.23.camel@frolic>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-17 at 00:17 +0200, Adrian Bunk wrote:

[snip]

> - #if 0 the following unused global function:
>   - bttv-gpio.c: bttv_gpio_irq()

This can be cut out, along with gpio_irq in the bttv_sub_driver struct
at bttv.h. 
It was originally used by bttv's remote-control sub-driver, which ceased
to exist a few months ago (the functionality was merged into the main
driver for consistency with other v4l modules).

Mauro, this is change 30d12f67fd01 at my repo. Pull at will.

--
RC

