Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262043AbVDLH6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262043AbVDLH6P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 03:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVDLH6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 03:58:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:50072 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262043AbVDLH6G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 03:58:06 -0400
Date: Tue, 12 Apr 2005 00:41:22 -0700
From: Greg KH <gregkh@suse.de>
To: "Viktor A. Danilov" <__die@mail.ru>
Cc: linux-kernel@vger.kernel.org, bwheadley@earthlink.net,
       chris@crud.net.kroah.org
Subject: Re: PROBLEM: AIPTEK input doesn`t register `device` & `driver` section in sysfs (/sys/class/input/event#)
Message-ID: <20050412074121.GE1371@kroah.com>
References: <200504101921.28777.__die@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504101921.28777.__die@mail.ru>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2005 at 07:21:28PM +0600, Viktor A. Danilov wrote:
> 
> PROBLEM: aiptek input doesn`t register `device` & `driver` section in sysfs (/sys/class/input/event#)
> REASON: `dev` - field not filled...
> SOLUTION: in linux/drivers/usb/input/aiptek.c write
> 	aiptek->inputdev.dev = &intf->dev;
> before calling 
> 	input_register_device(&aiptek->inputdev);

Good catch, I've applied this to my kernel trees.

thanks,

greg k-h
