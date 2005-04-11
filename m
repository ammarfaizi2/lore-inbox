Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261791AbVDKMQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261791AbVDKMQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 08:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261792AbVDKMQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 08:16:59 -0400
Received: from terminus.zytor.com ([209.128.68.124]:13528 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261791AbVDKMQ5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 08:16:57 -0400
Message-ID: <425A6AA1.3050601@zytor.com>
Date: Mon, 11 Apr 2005 05:16:33 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jayalk@intworks.biz
CC: linux-kernel@vger.kernel.org, davej@codemonkey.org.uk
Subject: Re: [PATCH 2.6.11.7 1/1] x86 reboot: Add reboot fixup for gx1/cs5530a
References: <200504110702.j3B72hau000852@intworks.biz>
In-Reply-To: <200504110702.j3B72hau000852@intworks.biz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jayalk@intworks.biz wrote:
> Hi Riley, Dave, Peter, i386 boot/workaround maintainers,
> 
> I'm resending this patch (from March 28). 
> 
> This patch incorporates the suggestions from the previous thread and also
> switches to using pci_get_device since pci_find_device is deprecated, and
> made some of the variables static.
> 
> Please let me know if it's okay.
> 

> +#define mach_reboot_fixups(x) do {} while (0)

As I stated last time, this should be:

#define mach_reboot_fixup(x)	((void)(x))

... to preserve side effects, and be expression-like.

	-hpa
