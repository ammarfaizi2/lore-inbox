Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWG1AfQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWG1AfQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 20:35:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750953AbWG1AfQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 20:35:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:35230 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750919AbWG1AfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 20:35:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=OshVM5qj4MYNukC9UkuJgmjg/qC9o90c+nU6eIQU4SgDge24xUKrQwzKThRrFT14zvsCnGeXmOSrI5rq4VJb7R6FiO15nJucga72O+PVmzSJ+jIUn5Bo8PLNl2kUxh2h78sJVbBS+ll7EUpwBdxY6yAYT2XZH0vg8qOmu9xQWOg=
Message-ID: <41840b750607271735v4330fd62yf37fdd418cab97e4@mail.gmail.com>
Date: Fri, 28 Jul 2006 03:35:10 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Vojtech Pavlik" <vojtech@suse.cz>
Subject: Re: Generic battery interface
Cc: "Pavel Machek" <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       "Matthew Garrett" <mjg59@srcf.ucam.org>,
       "kernel list" <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
In-Reply-To: <20060727233154.GB4907@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com>
	 <20060727221632.GE3797@elf.ucw.cz> <20060727233154.GB4907@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
>   note: It's absolutely necessary to limit the API to a well usable
>         SUBSET of a superset of the features of all drivers/devices,
>         even sacrificing obscure features to keep the API sane. One
>         example would be the HID Power spec, which simply can't be
>         supported to full extent by any sane API.

Non-standard functions must be handled reasonably within the
framework, otherwise drivers will have to build duplicate interfaces.

How about
  /sys/whatever/battery0/voltage for standard attributes
and
  /sys/whatever/battery0/thinkpad/inhibit-charge-minutes
for non-standard ones?


>   + and the kernel can change the polling frequency based on power
>         saving state changes

Likewise for cached attributes (query hardware only if N jiffies
passed since last querry, other return cached value). And that way,
hardware query frequency is never higher than what userspace actually
needs.

  Shem
