Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262094AbVCWXa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVCWXa2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 18:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262100AbVCWXa1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 18:30:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:29670 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262094AbVCWXaN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 18:30:13 -0500
Date: Wed, 23 Mar 2005 14:18:34 -0800
From: Greg KH <greg@kroah.com>
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] kobject/hotplug split
Message-ID: <20050323221834.GA5968@kroah.com>
References: <20050318040000.GA475@vrfy.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050318040000.GA475@vrfy.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 18, 2005 at 05:00:00AM +0100, Kay Sievers wrote:
> This splits the implicit generation of hotplug events from
> kobject_add() and kobject_del(), to give the driver core
> control over the time the event is created.
> 
> The kobject_register() and unregister functions still have the same
> behavior and emit the events by themselves.
> 
> The class, block and device core is changed now to emit the hotplug
> event _after_ the "dev" file, the "device" symlink and the default
> attributes are created. This will save udev from spinning in a stat() loop
> to wait for the files to appear, which is expensive if we have a lot of
> concurrent events.

Thanks for splitting this up.  I've applied all 6 to my trees now.

greg k-h
