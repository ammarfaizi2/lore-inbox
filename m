Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbUC0BSB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 20:18:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbUC0BSB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 20:18:01 -0500
Received: from mail.kroah.org ([65.200.24.183]:13214 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261541AbUC0BSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 20:18:00 -0500
Date: Fri, 26 Mar 2004 17:14:36 -0800
From: Greg KH <greg@kroah.com>
To: "Frank A. Uepping" <Frank.A.Uepping@t-online.de>
Cc: linux-kernel@vger.kernel.org, Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: struct device::release issue
Message-ID: <20040327011436.GB14076@kroah.com>
References: <200403061247.24251.Frank.A.Uepping@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200403061247.24251.Frank.A.Uepping@t-online.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2004 at 12:47:24PM +0100, Frank A. Uepping wrote:
> Hi,
> if device_add fails (e.g. bus_add_device returns an error) then the release 
> method will be called for the device. Is this a bug or a feature?

Are you sure this will happen?  device_initialize() gets a reference
that is still present after device_add() fails, right?  So release()
will not get called.

thanks,

greg k-h
