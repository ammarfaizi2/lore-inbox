Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264828AbUEEWgc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264828AbUEEWgc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264836AbUEEWgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:36:31 -0400
Received: from mail.kroah.org ([65.200.24.183]:18359 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264828AbUEEWfo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:35:44 -0400
Date: Wed, 5 May 2004 15:35:10 -0700
From: Greg KH <greg@kroah.com>
To: Hanna Linder <hannal@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, roms@lpg.ticalc.org, jb@technologeek.org
Subject: Re: [PATCH 2.6.6-rc3] Add class support to drivers/usb/misc/tiglusb.c
Message-ID: <20040505223510.GA30309@kroah.com>
References: <79660000.1083267538@dyn318071bld.beaverton.ibm.com> <20040502064915.GF3766@kroah.com> <36460000.1083795831@dyn318071bld.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36460000.1083795831@dyn318071bld.beaverton.ibm.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 03:23:51PM -0700, Hanna Linder wrote:
> +out_class:
> +	class_simple_device_remove(MKDEV(TIUSB_MAJOR, TIUSB_MINOR + s->minor));
> +	class_simple_destroy(tiglusb_class);

Ick, don't destroy the whole class.  Not good.

> +	class_simple_device_remove(MKDEV(TIUSB_MAJOR, TIUSB_MINOR + s->minor));
> +	class_simple_destroy(tiglusb_class);

Same thing here, you don't have to delete the class, only the class
device.

thanks,

greg k-h
