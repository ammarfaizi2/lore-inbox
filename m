Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262293AbUKWGpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262293AbUKWGpE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 01:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262281AbUKWGmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 01:42:42 -0500
Received: from mail.kroah.org ([69.55.234.183]:53178 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262275AbUKWGlz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 01:41:55 -0500
Date: Mon, 22 Nov 2004 22:30:45 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v1][9/12] Add InfiniBand userspace MAD support
Message-ID: <20041123063045.GA22493@kroah.com>
References: <20041122714.nKCPmH9LMhT0X7WE@topspin.com> <20041122714.9zlcKGKvXlpga8EP@topspin.com> <20041122225033.GD15634@kroah.com> <52ekil9v1m.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52ekil9v1m.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 06:08:21PM -0800, Roland Dreier wrote:
>     Greg> This could be in a sysfs file, right?
> 
> Ugh, how does one add an attribute (like the ABI version) to a
> class_simple?  It shouldn't be per-device but I don't see anything
> like class_create_file() that could work for class_simple.

class_simple_device_add returns a pointer to a struct class_device *
that you can then use to create a file in sysfs with.  That should be
what you're looking for.

thanks,

greg k-h
