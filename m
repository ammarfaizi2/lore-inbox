Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbVLWCFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbVLWCFH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 21:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030346AbVLWCFH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 21:05:07 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44808 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030321AbVLWCFF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 21:05:05 -0500
Date: Fri, 23 Dec 2005 03:05:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Marc Koschewski <marc@osknowledge.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] conditionally #ifdef-out unused DiB3000M-C/P defs
Message-ID: <20051223020504.GF27525@stusta.de>
References: <20051221113742.GA5611@stiffy.osknowledge.org> <20051221135244.GB5611@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051221135244.GB5611@stiffy.osknowledge.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 02:52:44PM +0100, Marc Koschewski wrote:
> This removes the declarations as well.

> *** dibusb.h-orig	2005-12-21 14:49:08.000000000 +0100
> --- dibusb.h	2005-12-21 14:49:30.000000000 +0100
> *************** struct dibusb_state {
> *** 104,111 ****
> --- 104,113 ----
>   
>   extern struct i2c_algorithm dibusb_i2c_algo;
>   
> + #ifdef CONFIG_DVB_USB_DIBUSB_MC
>   extern int dibusb_dib3000mc_frontend_attach(struct dvb_usb_device *);
>   extern int dibusb_dib3000mc_tuner_attach (struct dvb_usb_device *);
> + #endif
>...

There's no need to #ifdef function declarations away.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

