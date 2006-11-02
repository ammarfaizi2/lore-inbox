Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752886AbWKBOEq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752886AbWKBOEq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 09:04:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbWKBOEq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 09:04:46 -0500
Received: from cantor2.suse.de ([195.135.220.15]:2991 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1752883AbWKBOEp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 09:04:45 -0500
Subject: Re: [patch 4/6] Add output class document
From: Timo Hoenig <thoenig@nouse.net>
To: Yu Luming <luming.yu@gmail.com>
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       len.brown@intel.com, Matt Domsch <Matt_Domsch@dell.com>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       jengelh@linux01.gwdg.de, gelma@gelma.net, ismail@pardus.org.tr,
       Richard Hughes <hughsient@gmail.com>
In-Reply-To: <200611042122.00950.luming.yu@gmail.com>
References: <200611042122.00950.luming.yu@gmail.com>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 15:04:29 +0100
Message-Id: <1162476269.5888.17.camel@nouse.suse.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2006-11-04 at 21:22 +0800, Yu Luming wrote:

> diff --git a/Documentation/video-output.txt b/Documentation/video-output.txt
> new file mode 100644
> index 0000000..71b1dba
> --- /dev/null
> +++ b/Documentation/video-output.txt
> @@ -0,0 +1,34 @@
> +
> +		Video Output Switcher Control
> +		~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +		2006 luming.yu@gmail.com
> +
> +The output sysfs class driver is to provide video output abstract layer that 
> +can be used to hook platform specific methods to enable/disable video output
> +device through common sysfs interface. For example, on my IBM Thinkpad T42 
> +aptop, acpi video driver registered its output devices and read/write method
> +for state with output sysfs class. The user interface under sysfs is :

Rephrased, s/Thinkpad/ThinkPad, s/aptop/laptop, s/acpi/ACPI, kill
whitespace in front of colon: 

The output sysfs class driver provides an abstract video output layer that 
can be used to hook platform specific methods to enable/disable video output
devices through a common sysfs interface. For example, on my IBM ThinkPad T42 
laptop, the ACPI video driver registers its output devices and read/write methods
for 'state' with output sysfs class. The user interface under sysfs is:

The last but one sentence still sounds bogus to me, maybe someone else
has an idea.

> +linux:/sys/class/video_output # tree .
> +.
> +|-- CRT0
> +|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
> +|   |-- state
> +|   |-- subsystem -> ../../../class/video_output
> +|   `-- uevent
> +|-- DVI0
> +|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
> +|   |-- state
> +|   |-- subsystem -> ../../../class/video_output
> +|   `-- uevent
> +|-- LCD0
> +|   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
> +|   |-- state
> +|   |-- subsystem -> ../../../class/video_output
> +|   `-- uevent
> +`-- TV0
> +   |-- device -> ../../../devices/pci0000:00/0000:00:01.0
> +   |-- state
> +   |-- subsystem -> ../../../class/video_output
> +   `-- uevent
> +

Thanks,

   Timo

