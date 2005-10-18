Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932341AbVJRFuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932341AbVJRFuh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 01:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVJRFuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 01:50:37 -0400
Received: from mail.kroah.org ([69.55.234.183]:31877 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932341AbVJRFug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 01:50:36 -0400
Date: Mon, 17 Oct 2005 22:50:03 -0700
From: Greg KH <greg@kroah.com>
To: Aaron Gyes <floam@sh.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.14-rc4-mm1: udev/sysfs wierdness
Message-ID: <20051018055003.GA10488@kroah.com>
References: <1129610113.10504.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129610113.10504.4.camel@localhost>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 09:35:13PM -0700, Aaron Gyes wrote:
> For some reason this rule stopped working:
> 
> KERNEL=="event*", SYSFS{manufacturer}="Logitech", SYSFS{product}="USB
> Receiver", NAME="input/mx1000", MODE="0644"
> 
> Did stuff in /sys/ change? Do I need to change all my rules to make up
> for this? udevs fault? I do have the correct /dev/input/event0 node.

You have that node?  That's a good start :)

I think the "name" might have changed, it looks like I messed that up
somehow.  What does:
	 udevinfo -p /sys/class/input/input0/event0/ -a

show (or whatever that sysfs path is.)

Oops, heh, that dies on my box too.  Ok, I think that's the issue,
sorry.  I'm working on it...

thanks,

greg k-h
