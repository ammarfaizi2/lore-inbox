Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWGKLrn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWGKLrn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:47:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750998AbWGKLrn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:47:43 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:120 "EHLO
	mtaout02-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750859AbWGKLrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:47:42 -0400
Message-ID: <44B3912F.3010300@gentoo.org>
Date: Tue, 11 Jul 2006 12:53:19 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Michael Buesch <mb@bu3sch.de>
CC: Jeff Garzik <jgarzik@pobox.com>, Pavel Machek <pavel@ucw.cz>,
       yi.zhu@intel.com, jketreno@linux.intel.com,
       Netdev list <netdev@vger.kernel.org>, linville@tuxdriver.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [patch] do not allow IPW_2100=Y or IPW_2200=Y
References: <20060710152032.GA8540@elf.ucw.cz> <44B2940A.2080102@pobox.com> <200607102305.06572.mb@bu3sch.de>
In-Reply-To: <200607102305.06572.mb@bu3sch.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Buesch wrote:
> Does the ipw driver _really_ need the firmware on insmod time?
> bcm43xx, for example, loads the firmware on "ifconfig up" time.
> If ipw really needs the firmware on insmod, is it possible to
> defer it to later at "ifconfig up" time?

Is bcm43xx able to get the MAC address before the firmware is loaded?
Last time I checked, if the MAC address is only discovered after the 
interface is created (as would be the case with ipw loading firmware on 
ifconfig up, I think), interface renaming does not work.

Daniel
