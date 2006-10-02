Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWJBLX2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWJBLX2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 07:23:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbWJBLX2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 07:23:28 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:57608 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750928AbWJBLX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 07:23:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=qAV5rGTaEf4DNeeaPp/Ur3395I+cb1T002Xq8yUC5v2Bqwg3VUBydzBhinTXv7Iduq6Y2DhVCTuhEIV7iTQ5KCsvrGAwxIubaM8G1gDk8gE9hHnCu/6SLdfymj1HUuI7FUzo2aXHHrHabdruJU12V3gu0tN1Votb2GpbiwsVOas=
Date: Mon, 2 Oct 2006 13:25:49 +0200
From: Alessandro Guido <alessandro.guido@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net,
       ismail@pardus.org.tr
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi
 driver
Message-Id: <20061002132549.9d164061.alessandro.guido@gmail.com>
In-Reply-To: <20061001171912.b7aac1d8.akpm@osdl.org>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com>
	<20061001171912.b7aac1d8.akpm@osdl.org>
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.10.4; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 1 Oct 2006 17:19:12 -0700
Andrew Morton <akpm@osdl.org> wrote:
> 
> umm, OK, but now how do I adjust my screen brightness? ;)
> 
> I assume that cute userspace applications for controlling backlight
> brightness via the generic backlight driver either exist or are in
> progress?  What is the status of that?
> 

I use this tool: http://www.xs4all.nl/~bsamwel/laptop_mode/tools/
that automagically fires up whenever needed

$ cat /etc/laptop-mode/batt-start/brightness 
#!/bin/sh
echo -n CHOOSE_A_LOW_VALUE > /sys/class/backlight/sony/brightness

and

$ cat /etc/laptop-mode/batt-stop/brightness 
#!/bin/sh
let val="`</proc/acpi/sony/brightness_default` - 1"
echo -n "$val" > /sys/class/backlight/sony/brightness

But I seldom use my laptop in battery mode.

> I assume that cute userspace applications for controlling backlight
> brightness via the generic backlight driver either exist or are in
> progress?  What is the status of that?
> 

I think the new gnome-power-manager does it, but I'm not sure since I use Xfce.

> Thanks.

Thank you.
