Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262338AbUKDS70@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbUKDS70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 13:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbUKDS7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 13:59:05 -0500
Received: from mail.kroah.org ([69.55.234.183]:12996 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262327AbUKDS6q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 13:58:46 -0500
Date: Thu, 4 Nov 2004 10:58:26 -0800
From: Greg KH <greg@kroah.com>
To: Tejun Heo <tj@home-tj.org>
Cc: mochel@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.10-rc1 2/5] driver-model: bus_recan_devices() locking fix
Message-ID: <20041104185826.GA17756@kroah.com>
References: <20041104070134.GA25567@home-tj.org> <20041104070258.GC25567@home-tj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041104070258.GC25567@home-tj.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 04, 2004 at 04:02:58PM +0900, Tejun Heo wrote:
>  df_02_bus_rescan_devcies_fix.patch
> 
>  bus_rescan_devices() eventually calls device_attach() and thus
> requires write locking the corresponding bus.  The original code just
> called bus_for_each_dev() which only read locks the bus.  This patch
> separates __bus_for_each_dev() and __bus_for_each_drv(), which don't
> do locking themselves, out from the original functions and call them
> with read lock in the original functions and with write lock in
> bus_rescan_devices().
> 
> 
> Signed-off-by: Tejun Heo <tj@home-tj.org>

Thanks, I cleaned up the formatting a bit in this patch and applied it.

greg k-h
