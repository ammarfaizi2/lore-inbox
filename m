Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263942AbUEXXk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263942AbUEXXk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 19:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264102AbUEXXk1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 19:40:27 -0400
Received: from mail.kroah.org ([65.200.24.183]:31671 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263942AbUEXXkQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 19:40:16 -0400
Date: Mon, 24 May 2004 16:39:14 -0700
From: Greg KH <greg@kroah.com>
To: Andrew Zabolotny <zap@homelink.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: class_device_find()
Message-ID: <20040524233914.GI21244@kroah.com>
References: <20040523002309.2ec5965e.zap@homelink.ru> <20040524051303.GC27371@kroah.com> <20040524103921.7957533a.zap@homelink.ru> <20040524164630.GB1543@kroah.com> <20040525020803.759c5794.zap@homelink.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040525020803.759c5794.zap@homelink.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 25, 2004 at 02:08:03AM +0400, Andrew Zabolotny wrote:
> Ok, apart from this discussion, what you don't like about the
> class_device_find() function? I mean your fixed implementation. The locks are
> in place, the returned object has got his reference counter increased. Or,
> alternatively, any other ideas how we can solve the problem I've described in
> my previous message?

No in-kernel code uses it.  That's my main objection.  If a patch is
submitted that needs it, I'll reconsider it based on that patch.

> Also one more question. Do you think if it is okay if a subclass (such
> as the lcd device class) does strcpy() directly to class_device->class_id, or
> it is worth to add a function class_dev_set_name(struct class_device *, const
> char*)?

strncpy() is fine to do at this time.

thanks,

greg k-h
