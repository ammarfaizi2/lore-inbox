Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161589AbWJDQu0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161589AbWJDQu0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Oct 2006 12:50:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161599AbWJDQu0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Oct 2006 12:50:26 -0400
Received: from terminus.zytor.com ([192.83.249.54]:13705 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1161589AbWJDQuZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Oct 2006 12:50:25 -0400
Message-ID: <4523E63F.4050805@zytor.com>
Date: Wed, 04 Oct 2006 09:50:07 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Alex Owen <r.alex.owen@gmail.com>
CC: linux-kernel@vger.kernel.org, c-d.hailfinger.kernel.2004@gmx.net,
       aabdulla@nvidia.com
Subject: Re: forcedeth net driver: reverse mac address after pxe boot
References: <55c223960610040919u221deffei5a5b6c37cfc8eb5a@mail.gmail.com>
In-Reply-To: <55c223960610040919u221deffei5a5b6c37cfc8eb5a@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Owen wrote:
> 
> This is obviously causes me a problem with automated installs started
> via PXE boot as the installed cannot DHCP as the MAC address is wrong.
> 

I have a forcedeth system (ASUS A8N-E) which can't use either the Linux 
driver *or* the standard Windows driver *at all* after booting PXE and 
then exiting the PXE stack for local boot.

> The obvious fix for this is to try and read the MAC address from the
> canonical location... ie where is the source of the address writen
> into the controlers registers at power on? But do we know where that
> may be?
> 
> The other solution would be unconditionally reset the controler to
> it's power on state then use the current logic? can we reset the
> controller via software?
> There does seem to be an nv_mac_reset function... and this does seem
> to be called if the card has a capability DEV_HAS_POWER_CONTROL but it
> is called in nv_open() while the MAC is read in nv_probe().

Doing a proper reset of the hardware would be the right thing, assuming 
that this is safe/possible to do.

	-hpa
