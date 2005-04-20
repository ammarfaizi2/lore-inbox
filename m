Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbVDTSQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbVDTSQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 14:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261779AbVDTSQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 14:16:14 -0400
Received: from ipx10786.ipxserver.de ([80.190.251.108]:30603 "EHLO
	allen.werkleitz.de") by vger.kernel.org with ESMTP id S261777AbVDTSQL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 14:16:11 -0400
Date: Wed, 20 Apr 2005 20:15:45 +0200
From: Johannes Stezenbach <js@linuxtv.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-dvb-maintainer@linuxtv.org, linux-kernel@vger.kernel.org
Message-ID: <20050420181545.GA4876@linuxtv.org>
Mail-Followup-To: Johannes Stezenbach <js@linuxtv.org>,
	Adrian Bunk <bunk@stusta.de>, linux-dvb-maintainer@linuxtv.org,
	linux-kernel@vger.kernel.org
References: <20050419004308.GJ5489@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050419004308.GJ5489@stusta.de>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: 217.86.185.54
Subject: Re: [linux-dvb-maintainer] [2.6 patch] drivers/media/dvb/: possible cleanups
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on allen.werkleitz.de)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2005 at 02:43:08AM +0200, Adrian Bunk wrote:
> This patch contains the following possible cleanups:
> - make needlessly global code static
> - #if 0 the following unused global functions:
>   - dibusb/dvb-dibusb-usb.c: dibusb_set_streaming_mode
>   - frontends/mt352.c: mt352_read
>   - ttpci/av7110_hw.c: av7110_reset_arm
>   - ttpci/av7110_hw.c: av7110_send_ci_cmd
> - remove the following unneeded EXPORT_SYMBOL:
>   - frontends/mt352.c: mt352_read
> 
> Please review which of these changes do make sense.

I'll apply this patch to linuxtv.org CVS.

Most cleanups look fine, except the dibusb driver
has been superseded by a generalized dvb-usb driver.
mt352_read() can be dropped completely.

Thanks,
Johannes
