Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750838AbWJVSt3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750838AbWJVSt3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 14:49:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750845AbWJVSt3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 14:49:29 -0400
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:42504 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750838AbWJVSt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 14:49:27 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: "Aaron Cohen" <aaron@assonance.org>
Subject: Re: Ordering hotplug scripts vs. udev device node creation
Date: Sun, 22 Oct 2006 19:49:29 +0100
User-Agent: KMail/1.9.5
Cc: "LKML List" <linux-kernel@vger.kernel.org>
References: <727e50150610211021s7779b787s7bac8f409a3f2518@mail.gmail.com>
In-Reply-To: <727e50150610211021s7779b787s7bac8f409a3f2518@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610221949.29260.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 21 October 2006 18:21, Aaron Cohen wrote:
> Hope this is a reasonable list to post this to.
>
> I'm trying to modify the gpsd hotplug script to work better with my
> udev setup.  My USB serial devices are added to /dev/tts/USBx by udev
> and the default script assumes they are /dev/ttyUSBx.
>
> In any event, my hotplug script uses udevinfo to figure out the device
> file to use.  The problem seems to be though that my hotplug script is
> getting run before udev has actually created the device node.  Is
> there some ordering mechanism I'm missing that would help me out here?

Some distros have gotten rid of hotplug altogether and now use udev entirely 
for handling plugging events (udevd). It seems like what you could do here 
was write a simple udev rule to symlink the device when it's created.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
