Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030190AbWI0Lvu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030190AbWI0Lvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 07:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751124AbWI0Lvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 07:51:50 -0400
Received: from sd291.sivit.org ([194.146.225.122]:25872 "EHLO sd291.sivit.org")
	by vger.kernel.org with ESMTP id S1751121AbWI0Lvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 07:51:49 -0400
Message-ID: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net>
Date: Wed, 27 Sep 2006 13:51:46 +0200 (CEST)
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
From: stelian@popies.net
To: "Len Brown" <lenb@kernel.org>
Cc: "Andrew Morton" <akpm@osdl.org>, "Ismail Donmez" <ismail@pardus.org.tr>,
       "Stelian Pop" <stelian@popies.net>, "Andrea Gelmini" <gelma@gelma.net>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
User-Agent: SquirrelMail/1.4.4
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Will sony_acpi ever make it to the mainline? Its very useful for new
>> Vaio
>> > models.
>
> Nope, not as it is.  Useful != supportable.
>
> 1. It must not create any files under /proc/acpi
>     This is creating a machine-specific API, which
>     is exactly what we don't want  Nobody can maintain
>     50 machine specific APIs.
>
>     These objects must appear generic and under sysfs
>     as if acpi were not involved in providing them.
>
> 2. its source code shall not live in drivers/acpi
>     it is not part of the ACPI implementation after all --
>     it is a platform specific driver.

In this case, would a patch ripping off asus_acpi, ibm_acpi and
toshiba_acpi  from the kernel be accepted ?

I don't really care much about sony_acpi (since I'm not maintaining it
anymore, even if I still answer support requests about it), but this is
just silly. This has been going on for more than one and a half year now.

Meanwhile (at least from what I've seen), the ACPI subsystem still doesn't
provide this "generic" API which platform specific driver need to
implement. drivers/acpi/{hotkey.c,video.c} are just rudimentary, and there
is no indication that this is going forward:

In March 2005 you (Len) said:

> The goal is to DELETE ibm, toshiba, and asus drivers -- or at least the
> duplicated functions in them.
>
> platform specific drivers make it harder, not easier, to support more
> hardware -- there are a zillion vendors out there, implementing special
> drivers for each of them is a strategy of last resort.

and

> I'd like to keep this driver out-of-tree
> until we prove that we can't enhance the
> generic code to handle this hardware
> without the addition of a new driver.

How long is this going to take ?

Stelian.

