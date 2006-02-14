Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030258AbWBNDtP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbWBNDtP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 22:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030314AbWBNDtP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 22:49:15 -0500
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:1450 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030258AbWBNDtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 22:49:14 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alessandro Zummo <azummo-vger@towertech.it>
Subject: Re: [PATCH 01/11] RTC subsystem, class
Date: Mon, 13 Feb 2006 22:49:12 -0500
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060213225416.865078000@towertech.it> <20060213225417.074551000@towertech.it>
In-Reply-To: <20060213225417.074551000@towertech.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602132249.13055.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 17:54, Alessandro Zummo wrote:
> +
> +struct rtc_device
> +{
> +	int id;
> +	struct module *owner;
> +	struct class_device class_dev;
> +	struct semaphore ops_lock;

Alessandro,

I believe we are moving from struct semaphore to mutex whenever possible.
It would be nice if new code used new primitives.


-- 
Dmitry
