Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263666AbTJCEeg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 00:34:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263667AbTJCEeg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 00:34:36 -0400
Received: from mail.kroah.org ([65.200.24.183]:18616 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263666AbTJCEef (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 00:34:35 -0400
Date: Thu, 2 Oct 2003 21:33:25 -0700
From: Greg KH <greg@kroah.com>
To: Philippe =?iso-8859-1?Q?Gramoull=E9?= 
	<philippe.gramoulle@mmania.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test5-mm2] no /proc/bus/i2c but i2c-core module loaded + small oops
Message-ID: <20031003043325.GA16781@kroah.com>
References: <20031003043053.367eb89c.philippe.gramoulle@mmania.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031003043053.367eb89c.philippe.gramoulle@mmania.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 03, 2003 at 04:30:53AM +0200, Philippe Gramoullé wrote:
> 
>  Hello,
> 
> Symptoms: modprobe i2c-core works fine but /proc/bus/i2c doesn't exist

/proc/bus/i2c will never exist :)

lmsensors has not been ported to 2.6 yet, sorry.  Look in /sys/bus/i2c
for the devices and sensors.

> Device class 'i2c-0' does not have a release() function, it is broken and must be fixed.
> Badness in class_dev_release at drivers/base/class.c:200

bah, forget to fix this one up.  Will get to it in the next few days.

thanks,

greg k-h
