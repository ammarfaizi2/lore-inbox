Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbWDNVu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbWDNVu1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 17:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965186AbWDNVu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 17:50:27 -0400
Received: from smtpq3.groni1.gr.home.nl ([213.51.130.202]:5267 "EHLO
	smtpq3.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S965120AbWDNVu1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 17:50:27 -0400
Message-ID: <44401991.70100@keyaccess.nl>
Date: Fri, 14 Apr 2006 23:52:17 +0200
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: MrUmunhum@popdial.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Which device did I boot from?
References: <44401071.5080700@popdial.com>
In-Reply-To: <44401071.5080700@popdial.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Estrada wrote:

> Is there a way to determine which device I have booted from?  For
> example, say I booted from a USB device, can I tell which one?  I did
> not find anything in /proc FS other than the cmdline options.

If you choose the (experimental) CONFIG_EDD option in your kernel then, 
with cooperation of your BIOS, you'll have a /sys/firmware/edd with at 
least some info about the BIOS boot device. For me:

/sys/firmware/edd/
`-- int13_dev80
     |-- extensions
     |-- info_flags
     |-- legacy_max_cylinder
     |-- legacy_max_head
     |-- legacy_sectors_per_track
     |-- mbr_signature
     |-- raw_data
     |-- sectors
     `-- version

I do not appear to have enough information there to be able to translate 
back to the linux device but drivers/firmware/edd.c seems to imply there 
might be for others. As far as I'm aware, it's the best that's available 
at least.

Rene.
