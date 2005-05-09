Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263052AbVEIGCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263052AbVEIGCm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 02:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263055AbVEIGCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 02:02:42 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:35249 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263052AbVEIGCg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 02:02:36 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Mitch <Mitch@0Bits.COM>
Subject: Re: [RFT/PATCH] KVMS, mouse losing sync and going crazy
Date: Mon, 9 May 2005 01:02:33 -0500
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
References: <427EF9D5.2010606@0Bits.COM>
In-Reply-To: <427EF9D5.2010606@0Bits.COM>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505090102.33395.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 May 2005 00:49, Mitch wrote:
> I applied your v4 patch, and that fixes it somewhat insomuch as it it 
> working, but it keeps resetting itself if i stop using it for a few 
> milliseconds, so the mouse appears sluggish as it performs a reset 
> whenever i use it. Here are the messages i see (100's of them).
> 
> ALPS Touchpad (Dualpoint) detected
>    Disabling hardware tapping
> input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
> psmouse.c: resync failed, issuing reconnect request
> psmouse.c: resync failed, issuing reconnect request
> ALPS Touchpad (Dualpoint) detected
>    Disabling hardware tapping
> input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
> psmouse.c: resync failed, issuing reconnect request
> ALPS Touchpad (Dualpoint) detected
>    Disabling hardware tapping
> input: AlpsPS/2 ALPS TouchPad on isa0060/serio1
>

Could you please do the following:

1. Reboot with the patch applied
2. "echo 1 > /sys/modules/i8042/parameters/debug"
3. Wait 5-10 seconds
4. Touch your touchpad briefly
5. "echo 0 > /sys/modules/i8042/parameters/debug"
6. send me dmesg

Thanks!

-- 
Dmitry
