Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266246AbUBJShl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 13:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266237AbUBJShT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 13:37:19 -0500
Received: from mail.kroah.org ([65.200.24.183]:58006 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266240AbUBJSfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 13:35:34 -0500
Date: Tue, 10 Feb 2004 10:35:39 -0800
From: Greg KH <greg@kroah.com>
To: Mike Bell <kernel@mikebell.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfs vs udev, thoughts from a devfs user
Message-ID: <20040210183539.GJ28111@kroah.com>
Reply-To: linux-kernel@vger.kernel.org
References: <20040210113417.GD4421@tinyvaio.nome.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040210113417.GD4421@tinyvaio.nome.ca>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 10, 2004 at 03:34:18AM -0800, Mike Bell wrote:
> I've been reading a lot lately about udev and how it's both very
> different to and much better than devfs, and with _most_ of the reasons
> given, I can't see how either is the case. I'd like to lay out why I
> think that is.

One final comment:  Can you implement a persistent device naming scheme
using devfs today?  If so, please show me how you would:
	- always name a USB printer the same /dev name no matter when it
	  is discovered by the USB core (before or after any other USB
	  printer.)
	- always name your SCSI disk the same /dev name no matter where
	  in the scsi probe sequence it is (yank it out and plug it into
	  another place in your scsi rack.)

This is the main problem that udev solves.  The fact that it also gives
you a dynamic /dev is just extra goodness.

thanks,

greg k-h
