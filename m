Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751648AbWG0PKr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbWG0PKr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751647AbWG0PKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:10:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:49751 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750745AbWG0PKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:10:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sKrwtLFglMFtRJd9yGOkeSmXfwyCV11HE8TNBl1NKzDZofiXEpWkk2QnbsUph3Nl0bN3n5QtNVD5LZ4WYXosowpA5ScpN9HPGObI4uLx1/O/kDhYLpNbHYNpR+VULJ63uuxwZLgW/GmNyeidfUB0oVIKAyuloJxQq+qwhlQLbAQ=
Message-ID: <41840b750607270810o3e9fe18epff4d01eceec7dda0@mail.gmail.com>
Date: Thu, 27 Jul 2006 18:10:44 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: Generic battery interface
Cc: "Matthew Garrett" <mjg59@srcf.ucam.org>, vojtech@suse.cz,
       "Len Brown" <len.brown@intel.com>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org
In-Reply-To: <20060727145944.GB3131@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060727002035.GA2896@elf.ucw.cz>
	 <20060727140539.GA10835@srcf.ucam.org>
	 <41840b750607270739u7b6fe7efl5ac5ec147d83e624@mail.gmail.com>
	 <20060727145944.GB3131@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/27/06, Pavel Machek <pavel@suse.cz> wrote:
> Well, in that case probably smapi driver should "hook into" acpi
> driver.

That would be odd, the SMAPI driver has nothing to do with the ACPI
system. I don't think cross-system hooks are very popular...


> Worst case, we would get equivalent of
>
> /sys/class/battery/system_battery_acpi/...
> /sys/class/battery/system_battery_some_clever_vendor_hack/...
>
> with some values common between both of them. I'd say it is still
> better than having vendor_hack in /sys in one format while having acpi
> battery in /proc/acpi in completely different format.

Aye, we need for a consistent interface to common functionality.
How about /sys/class/battery/{acpi,apm,thinkpad}/BAT0?
So that for standard attributes, cat /sys/class/battery/*/BAT0/voltage
gives something reasonable.

  Shem
