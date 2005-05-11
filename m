Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261999AbVEKRJ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261999AbVEKRJ1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVEKRJ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:09:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:52162 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262001AbVEKRIa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:08:30 -0400
Date: Wed, 11 May 2005 10:07:50 -0700
From: Greg KH <greg@kroah.com>
To: Yani Ioannou <yani.ioannou@gmail.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>, linux-kernel@vger.kernel.org,
       Justin Thiessen <jthiessen@penguincomputing.com>
Subject: Re: [PATCH 2.6.12-rc4 3/3] (dynamic sysfs callbacks) device_attribute
Message-ID: <20050511170750.GE15398@kroah.com>
References: <2538186705051100583c6b1ffb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2538186705051100583c6b1ffb@mail.gmail.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2005 at 03:58:35AM -0400, Yani Ioannou wrote:
> -static ssize_t show_in(struct device *dev, char *buf, int nr)
> +static ssize_t show_in(struct device *dev, char *buf, void *private)
>  {
> +	int nr = *((int*)private);

What's wrong with a simple:
	int nr = (int)private;

thanks,

greg k-h
