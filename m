Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbUKWHpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbUKWHpb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 02:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbUKWHn7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 02:43:59 -0500
Received: from mail.kroah.org ([69.55.234.183]:5604 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262309AbUKWHns (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 02:43:48 -0500
Date: Mon, 22 Nov 2004 23:43:37 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: Re: [PATCH][RFC/v1][9/12] Add InfiniBand userspace MAD support
Message-ID: <20041123074337.GB23194@kroah.com>
References: <20041122714.nKCPmH9LMhT0X7WE@topspin.com> <20041122714.9zlcKGKvXlpga8EP@topspin.com> <20041122225033.GD15634@kroah.com> <52ekil9v1m.fsf@topspin.com> <20041123063045.GA22493@kroah.com> <52llct83o1.fsf@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52llct83o1.fsf@topspin.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 22, 2004 at 10:45:02PM -0800, Roland Dreier wrote:
>     Greg> class_simple_device_add returns a pointer to a struct
>     Greg> class_device * that you can then use to create a file in
>     Greg> sysfs with.  That should be what you're looking for.
> 
> Shouldn't the ABI version be an attribute in /sys/class/infiniband_mad
> rather than being per-device?

Yes, it probably should be.  Hm, no, we don't allow you to put class
specific files if you use the class_simple API, sorry I misread your
question.  You can just handle the class yourself and use the
CLASS_ATTR() macro to define your api version function.

thanks,

greg k-h
