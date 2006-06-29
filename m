Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751390AbWF2DAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751390AbWF2DAJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 23:00:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbWF2DAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 23:00:09 -0400
Received: from wr-out-0506.google.com ([64.233.184.228]:37289 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750980AbWF2DAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 23:00:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p//9qbL5u/0X7bPlFljSvNmy3xX6tDfkfiavbWMTSsBCchys1QejfMQ91tjso5BJV2lzGSb5IPtX+fCmlSOpRVIVb0C3BJ1UuVIPyznufd7EQFjXpi7YEQjadzwKdiA7Sdu65ID2oZiytp6FY/nLy802SCEe60s+oBA9c8c+5m0=
Message-ID: <ef88c0e00606282000l1c63216dx9ecd5f53a41cde8c@mail.gmail.com>
Date: Wed, 28 Jun 2006 20:00:06 -0700
From: "Ken Brush" <kbrush@gmail.com>
To: "Andy Gay" <andy@andynet.net>
Subject: Re: [linux-usb-devel] USB driver for Sierra Wireless EM5625/MC5720 1xEVDO modules
Cc: "Greg KH" <gregkh@suse.de>, "Jeremy Fitzhardinge" <jeremy@goop.org>,
       linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
In-Reply-To: <1151537247.3285.278.camel@tahini.andynet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1151537247.3285.278.camel@tahini.andynet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/06, Andy Gay <andy@andynet.net> wrote:
> I have adapted the modified Airprime driver that Greg posted a few weeks
> ago to add support for these 2 modules.
>
> That driver works for these modules if the USB IDs are added, and fixes
> the throughput problems in the earlier driver. I had to make some
> changes though -
>
> - there's a memory leak because the transfer buffers are kmalloc'ed
> every time the device is opened, but they're never freed;
>
> - these modules present 3 bulk EPs, the 2nd & 3rd can be used for
> control & status monitoring while data transfer is in progress on the
> 1st EP. This is useful (and necessary for my application) so we need to
> increase the port count.
>
> So what should I do next? I see a few possibilities, assuming anyone is
> interested in this:
>
> - I could post a diff from Greg's driver. But I don't have hardware to
> test whether my changes will break it for the other devices that it
> supports;
>
> - I could post it as a new driver for just these 2 modules, using some
> other name;
>
> - I could post it as a replacement for Greg's driver (which isn't yet in
> the official sources, I think), including all the USB IDs, if someone
> can test it for the other devices.

I'd be willing to test it out on my aircard 580 if you post it.

-Ken
