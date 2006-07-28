Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932611AbWG1KL6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932611AbWG1KL6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 06:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbWG1KL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 06:11:58 -0400
Received: from styx.suse.cz ([82.119.242.94]:5354 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S932607AbWG1KL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 06:11:57 -0400
Date: Fri, 28 Jul 2006 12:11:53 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Pavel Machek <pavel@suse.cz>, "Brown, Len" <len.brown@intel.com>,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, linux-acpi@vger.kernel.org
Subject: Re: Generic battery interface
Message-ID: <20060728101153.GC25372@suse.cz>
References: <CFF307C98FEABE47A452B27C06B85BB6011688D8@hdsmsx411.amr.corp.intel.com> <20060727221632.GE3797@elf.ucw.cz> <20060727233154.GB4907@suse.cz> <41840b750607271735v4330fd62yf37fdd418cab97e4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607271735v4330fd62yf37fdd418cab97e4@mail.gmail.com>
X-Bounce-Cookie: It's a lemon tree, dear Watson!
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 03:35:10AM +0300, Shem Multinymous wrote:
> On 7/28/06, Vojtech Pavlik <vojtech@suse.cz> wrote:
> >  note: It's absolutely necessary to limit the API to a well usable
> >        SUBSET of a superset of the features of all drivers/devices,
> >        even sacrificing obscure features to keep the API sane. One
> >        example would be the HID Power spec, which simply can't be
> >        supported to full extent by any sane API.
> 
> Non-standard functions must be handled reasonably within the
> framework, otherwise drivers will have to build duplicate interfaces.
> 
> How about
>  /sys/whatever/battery0/voltage for standard attributes
> and
>  /sys/whatever/battery0/thinkpad/inhibit-charge-minutes
> for non-standard ones?

I think the thinkpad features actually fall into the 'standard API', if
not for any other reason, then because some 80% of kernel developers use
ThinkPads. ;)

> >  + and the kernel can change the polling frequency based on power
> >        saving state changes
> 
> Likewise for cached attributes (query hardware only if N jiffies
> passed since last querry, other return cached value). And that way,
> hardware query frequency is never higher than what userspace actually
> needs.
 

-- 
Vojtech Pavlik
Director SuSE Labs
