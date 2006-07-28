Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161132AbWG1MZk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161132AbWG1MZk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 08:25:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161138AbWG1MZk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 08:25:40 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:31030 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1161132AbWG1MZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 08:25:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ei+rbD6aUAAjUOk3gAgkz6bXiSD9w0o3NfQPBC6kjXsyoXin2uSgO5IPfwIkI6ONyl4Uj9gW0DZttyrLNGFQMSnWOhGRjaDMX17nAcphrSvMYwzGyhJ1rU5muJJYzZldKINeT+sEm3DMZSi1vcGNa55UZXOoLXVTL/0TaeOBusw=
Message-ID: <d120d5000607280525x447e6821t734a735197481c18@mail.gmail.com>
Date: Fri, 28 Jul 2006 08:25:35 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Generic battery interface
Cc: "Shem Multinymous" <multinymous@gmail.com>,
       "Brown, Len" <len.brown@intel.com>, "Pavel Machek" <pavel@suse.cz>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <20060728074202.GA4757@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <41840b750607271332q5dea0848y2284b30a48f78ea7@mail.gmail.com>
	 <20060727232427.GA4907@suse.cz>
	 <41840b750607271727q7efc0bb2q706a17654004cbbc@mail.gmail.com>
	 <20060728074202.GA4757@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Fri, Jul 28, 2006 at 03:27:00AM +0300, Shem Multinymous wrote:
> >
> > "Generic interface for accelerometers (AMS, HDAPS, ...)" on LKML, a
> > few weeks ago, about moving accelerator-based hard disk parking from
> > sysfs polling to the the input infrastructure. One unresolved issue
> > was how to find which input device happens to be the relevant
> > accelerometer.
>
> The current well known methods are:
>
>        1) udev/hotplug. It can create device nodes and symlinks based on the
>                capabilities and IDs of an input device.
>        1a) HAL. It has all the info from hotplug as well.
>        2) open them all and do the capability checks / IDs yourself.
>        3) (obsolete, deprecated) parse /proc/bus/input/devices, which
>                lists all the input devices
>

4) sysfs - all capabilities, IDs, etc for input devices exported there as well.

-- 
Dmitry
