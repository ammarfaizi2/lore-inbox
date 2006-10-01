Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751546AbWJACRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751546AbWJACRo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 22:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751547AbWJACRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 22:17:44 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:12397 "EHLO
	asav01.insightbb.com") by vger.kernel.org with ESMTP
	id S1751534AbWJACRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 22:17:44 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AbgeAEHBHkWBTogSgg8s
From: Dmitry Torokhov <dtor@insightbb.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: appletouch vs. usbhid
Date: Sat, 30 Sep 2006 22:17:39 -0400
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20060930142003.8ba909b1.zaitcev@redhat.com>
In-Reply-To: <20060930142003.8ba909b1.zaitcev@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609302217.40895.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pete,

On Saturday 30 September 2006 17:20, Pete Zaitcev wrote:
> Dear Dmitry:
> 
> A user filed a bug here which seems to indicate that hid lacks needed
> exclusions for Apple pointers:
>  https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=208721
> Do you think we should be adding QUIRK_IGNORE for these?

Yes, I think we should.

> Perhaps conditional on CONFIG_USB_APPLETOUCH?

No, I think we should just do that unconditionally and have users select
appletouch driver.

> 
> We used to have those IGNORE quirks for Wacom, but then started to ignore
> all Wacoms. We seem to be not at that point with Apple yet, and also they
> have varying vendor IDs.
>

Ping Cheng swore that Wacom never produced HID-compiant device and that
it would be easier for her if we blacklisted Wacom as vendor in HID...

-- 
Dmitry
