Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1760672AbWLFTG1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760672AbWLFTG1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 14:06:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760613AbWLFTG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 14:06:26 -0500
Received: from wx-out-0506.google.com ([66.249.82.232]:28924 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759351AbWLFTGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 14:06:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=b9xHxHMxRuOCcbNQIMKeTr/ugd++HrNHVbcl9gYAkVlyn3xfp48N1znp7sexnnCyq1rw2FpWU9HFDIChn9LQAzahP0jG/m6ngaLHLEfTXBWknsT2WBVAKDwKRuHquZUUT4mOdpbFuRxJoHrHkyZzU/7CA4yYOQ8ljW8aD+WRKl0=
Message-ID: <653402b90612061106i2071ba75ka1a14de6829c85b5@mail.gmail.com>
Date: Wed, 6 Dec 2006 20:06:24 +0100
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: jsimmons@infradead.org
Subject: Re: Display class
Cc: linux-kernel@vger.kernel.org, Luming.yu@intel.com, zap@homelink.ru,
       randy.dunlap@oracle.com, kernel-discuss@handhelds.org
In-Reply-To: <20061206194442.422c60d3.maxextreme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061206194442.422c60d3.maxextreme@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/06, Miguel Ojeda Sandonis <maxextreme@gmail.com> wrote:
> Ok, here is the patch (against git7+displayclass) which moves auxdisplay/*
> to video/display/* and start using the display class.
>
> It is just a draft, but there isn't much code changed from -mm2.
>
>   - I would remove "struct device *dev, void *devdata" of display_device_register()
>     Are they neccesary for other display drivers? I have to pass NULL right now.
>
>   - I would add a paramtere ("char *name") to display_device_register() so we
>     set the name when registering. Right now I have to set my name after inited,
>     and this is a Linux module and not a person borning, right? ;)
>
>   - I would add a read/writeable attr called "rate" for set/unset the refresh rate
>     of a display.
>
>   - I was going to maintain the drivers/auxdisplay/* tree.
>     Are you going to maintain the driver? I think so, just for being sure.

I meant display driver (display/*).

>
> P.S.
>
>   When I was working at 2.6.19-rc6-mm2 it worked all fine, but now
>   I have copied it to git7 I'm getting some weird segmentation faults
>   (oops) when at cfag12864bfb_init, at mutex_lock() in
>   display_device_unregister module... I think unrelated (?), but I will
>

I meant display_device_unregister function of display-sysfs.c

--

The changes have been made in driver/video/display/cfag12864bfb.c, so
please focus the review on it.

Thanks
