Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262612AbVGMLum@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262612AbVGMLum (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 07:50:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262706AbVGMLum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 07:50:42 -0400
Received: from mta08-winn.ispmail.ntl.com ([81.103.221.48]:14886 "EHLO
	mta08-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S262612AbVGMLuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 07:50:40 -0400
Message-ID: <42D50033.9040009@gentoo.org>
Date: Wed, 13 Jul 2005 12:51:15 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050710)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Hamish Marson <hamish@travellingkiwi.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: SysKonnect ethernet support for Asus A8VE Deluxe Motherboard?
References: <42D3FDF5.4090501@travellingkiwi.com>
In-Reply-To: <42D3FDF5.4090501@travellingkiwi.com>
X-Enigmail-Version: 0.92.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hamish Marson wrote:
> I just installed Gentoo distribution on a new PC for a friend who's
> new to Linux, and discovered that although SysKonnect kindly provide
> full source code drivers for their various products on their website,
> that even the latest released kernel sources (i.e. 2.6.12) still don't
> support the device on this motherboard (Along with a whole host of
> other PCI id's that appear in the syskonnect sources).

Gentoo 2.6.12 kernels provide the skge driver which supports this hardware (I
believe). skge will be included in mainline 2.6.13.

> I've logged a bug on gentoo.org about it, but thought I'd ask, if
> there's any reason that the syskonnect (sk98lin) drivers are so back
> leve in the kernel sources when syskonnect seem to have published the
> drivers for so many more of their devices in source...

The driver updates that syskonnect released are ugly and have been rejected by
the network driver maintainers. skge was written as a response to this.

The very latest sk98lin updates add support for the new Yukon-II PCI-express
adapters. These are not supported by skge -- the Yukon-II is very different
and will eventually be supported by a separate driver. The techniques which
sk98lin uses to support two vastly different network chipsets (yukon/yukon-II)
in the same driver are generally not accepted in the kernel.

Daniel
