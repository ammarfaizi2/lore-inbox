Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVFPSwY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVFPSwY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Jun 2005 14:52:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVFPSwY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Jun 2005 14:52:24 -0400
Received: from mail.kroah.org ([69.55.234.183]:27111 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261785AbVFPSwV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Jun 2005 14:52:21 -0400
Date: Thu, 16 Jun 2005 11:52:02 -0700
From: Greg KH <greg@kroah.com>
To: Abhay Salunke <Abhay_Salunke@dell.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>, matt_domsch@dell.com
Subject: Re: [patch 2.6.12-rc3] dell_rbu: Resubmitting patch for new Dell BIOS update driver
Message-ID: <20050616185202.GA11657@kroah.com>
References: <20050615175946.GA1495@littleblue.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050615175946.GA1495@littleblue.us.dell.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2005 at 12:59:46PM -0500, Abhay Salunke wrote:
> +static struct device rbu_device_mono;
> +static struct device rbu_device_packet;
> +static struct device rbu_device_cancel;

You should never create a struct device on the stack.  Lots of bad
things can happen (including not having a release function for them.)

Why not just point to the cpu device, or some other platform or system
device?

thanks,

greg k-h
