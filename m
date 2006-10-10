Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWJJPRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWJJPRb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 11:17:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWJJPRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 11:17:31 -0400
Received: from py-out-1112.google.com ([64.233.166.177]:23631 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750854AbWJJPR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 11:17:29 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=a1ak2VNJZlZ/xcTugVbjG3KvqIHxaqY/qJZUuAX6x6Igq5DNdWkb9TayvtNr/v+vxoXLZHSt+ewGu0GbH6iTSW7wJdllO3aNrvSw7Um1DritiNyZkY3bj8GUbzusUEBrVT7g3bOY1mlJ3cnvKMaXTGa6dJ/rocPcDporyxwDGLk=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Alessandro Guido <alessandro.guido@gmail.com>
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the sony_acpi driver
Date: Tue, 10 Oct 2006 23:17:23 +0800
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-acpi@vger.kernel.org, len.brown@intel.com,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr
References: <20060930190810.30b8737f.alessandro.guido@gmail.com> <20061001171912.b7aac1d8.akpm@osdl.org> <20061002132549.9d164061.alessandro.guido@gmail.com>
In-Reply-To: <20061002132549.9d164061.alessandro.guido@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610102317.24310.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I use this tool: http://www.xs4all.nl/~bsamwel/laptop_mode/tools/
> that automagically fires up whenever needed
>
> $ cat /etc/laptop-mode/batt-start/brightness
> #!/bin/sh
> echo -n CHOOSE_A_LOW_VALUE > /sys/class/backlight/sony/brightness

Also, we need to make hot-key events  have similar handling code .
For example, Fn+F5 and Fn+F6 are brightness down and up key on my sony laptop.  
There is a driver called sonypi.c can map Fn+F5/F6 to KEY_FN_F5/F6. But I 
think It should be mapped to KEY_BRIGHTNESSDOWN/UP (linux/input.h)
Although, sonypi.c is NOT so clean, but , if it can report right event to 
input layer for all sony laptop(it works for me), and all related functions 
can be controlled through generic sysfs interface, then I would say sony has 
the best hot-key solution I have even seen so far for linux.

Thanks,
Luming.



