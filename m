Return-Path: <linux-kernel-owner+w=401wt.eu-S964810AbXASSO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964810AbXASSO1 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 19 Jan 2007 13:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbXASSOY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Jan 2007 13:14:24 -0500
Received: from styx.suse.cz ([82.119.242.94]:38344 "EHLO mail.suse.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S964810AbXASSOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Jan 2007 13:14:22 -0500
Date: Fri, 19 Jan 2007 19:14:16 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Anssi Hannula <anssi.hannula@gmail.com>
Cc: linux-usb-devel <linux-usb-devel@lists.sourceforge.net>,
       linux-input@atrey.karlin.mff.cuni.cz,
       LKML <linux-kernel@vger.kernel.org>,
       Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [patch] hid: put usb_interface instead of usb_device into hid->dev
In-Reply-To: <45B0FFB1.3000900@gmail.com>
Message-ID: <Pine.LNX.4.64.0701191907580.31347@jikos.suse.cz>
References: <45B0FFB1.3000900@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Jan 2007, Anssi Hannula wrote:

> The commit 4916b3a57fc94664677d439b911b8aaf86c7ec23 introduced a
> hid regression between 2.6.19 and 2.6.20-rc1. The device put in
> input_dev->cdev is now of type usb_device instead of usb_interface.

Yes, this is apparently a bug. Thanks a lot for the patch.

> Fix this by assigning the intf->dev into hid->dev, and fixing all the 
> users.
> 
> Signed-off-by: Anssi Hannula <anssi.hannula@gmail.com>
> 
> ---
> 
> I recommend this fix to go to the stable tree before 2.6.20 is released.

Looks OK to me. I have queued it in HID tree - I am going to push this 
upstream in a few days.

-- 
Jiri Kosina

