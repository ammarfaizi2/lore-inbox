Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965006AbWI1PtT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965006AbWI1PtT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 11:49:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965012AbWI1PtS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 11:49:18 -0400
Received: from py-out-1112.google.com ([64.233.166.180]:12521 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964989AbWI1PtP convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 11:49:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:organization:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Zd+74mDd5gVsk4HcpzL2I9uml0RPYgVxaeez4mCL/ArYtYEV5dG8tZkPVgdFy/9QLJvtNrraazkYjgyGkSV89cInQ7h8Z4Xa8cZpjwlsL0QRj7Q+HimKw4I5gMQF/xsb/tmleChVXh14wvY7kHPNZxNqKTBqY1s/+Ip6L2BGPyM=
From: Yu Luming <luming.yu@gmail.com>
Organization: gmail
To: Ismail Donmez <ismail@pardus.org.tr>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Date: Thu, 28 Sep 2006 23:48:58 +0800
User-Agent: KMail/1.8.2
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>,
       Stelian Pop <stelian@popies.net>, Andrea Gelmini <gelma@gelma.net>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
References: <20060926135659.GA3685@jnb.gelma.net> <200609270204.38970.len.brown@intel.com> <200609271050.03904.ismail@pardus.org.tr>
In-Reply-To: <200609271050.03904.ismail@pardus.org.tr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609282348.58888.luming.yu@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 27 September 2006 15:50, Ismail Donmez wrote:
> Hi,
> 27 Eyl 2006 Çar 09:04 tarihinde, Len Brown şunları yazmıştı:
> [...]
>
> > > > Will sony_acpi ever make it to the mainline? Its very useful for new
> > > > Vaio models.
> >
> > Nope, not as it is.  Useful != supportable.
> >
> > 1. It must not create any files under /proc/acpi
> >     This is creating a machine-specific API, which
> >     is exactly what we don't want  Nobody can maintain
> >     50 machine specific APIs.
> >
> >     These objects must appear generic and under sysfs
> >     as if acpi were not involved in providing them.

Yes, the idea of generic code and sysfs things can
remove the supportable issues as to complete different
user interface exposed in /proc/acpi/ by different
platform specific drivers such as ibm_acpi.c,
asus_acpi.c, and toshiba_acpi.c,....

> >
> > 2. its source code shall not live in drivers/acpi
> >     it is not part of the ACPI implementation after all --
> >     it is a platform specific driver.
>
> Is there a such example code under kernel now, so one could look at it and
> fix sony_acpi driver.

Please take a look at drivers/video/backlight..
And here is a example to use backlight class for acpi video driver:
http://marc.theaimsgroup.com/?l=linux-acpi&m=115574087203605&w=2

Please let me know if you have any other ideas to consolidate the
platform specific drivers such as ibm_acpi.c ,asus_acpi.c, toshiba_acpi.c
panasonic_acpi.c, sony_acpi.c , msi s270.c .....

Thanks,
Luming

