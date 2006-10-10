Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750698AbWJJOzZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750698AbWJJOzZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 10:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWJJOzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 10:55:24 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:15039 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750698AbWJJOzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 10:55:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=ZTLn7JhuA8xwfXZmYSogGpl7peHtQJK8kLpC7H2U+17pdN9j+tRDwTQTngsaR623sywH1yHGPEZj8Ss+CjHcLT7ItDrF6S4CatGYCpJNcGPSsl4ES6zv0w3mNvcBYLGecQqamYJpDtVvjUqmv0iky5Qk005GEZ4qO3D4B79cOQ4=
Subject: Re: [PATCH 2.6.18-mm2] acpi: add backlight support to the
	sony_acpi driver
From: Richard Hughes <hughsient@gmail.com>
To: Yu Luming <luming.yu@gmail.com>
Cc: Matt Domsch <Matt_Domsch@dell.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Alessandro Guido <alessandro.guido@gmail.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com, jengelh@linux01.gwdg.de, gelma@gelma.net,
       ismail@pardus.org.tr
In-Reply-To: <200610102232.46627.luming.yu@gmail.com>
References: <20060930190810.30b8737f.alessandro.guido@gmail.com>
	 <20061005103657.GA4474@ucw.cz> <20061006211751.GA31887@lists.us.dell.com>
	 <200610102232.46627.luming.yu@gmail.com>
Content-Type: text/plain
Date: Tue, 10 Oct 2006 15:47:26 +0100
Message-Id: <1160491646.6174.36.camel@hughsie-laptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 22:32 +0800, Yu Luming wrote:
> >From my understanding, a cute userspace App shouldn't have this kind
> of logic:
>         if (is  DELL )
>                 invoke libsmbios
>         if (is  foo)
>                 invoke libfoo,
>         if (is bar)
>                 invoke libbar,
>         ....
>         else
>                 operate on /sys/class/backlight/ ,.,..

This is what HAL has at the moment[1]. And it's hell to maintain, but
works for a lot of users.

> It should be:
>         just write/read  file in  /sys/class/backlight ,....

That would make things much easier IMO.

Richard.

[1]
http://gitweb.freedesktop.org/?p=hal.git;a=blob;h=3ff9284be440a7197b0de9b5f0234761c3397cb1;hb=dbffafacbf7b9143d82547b9eabe61d1a5b8fffc;f=tools/linux/hal-system-lcd-get-brightness-linux

