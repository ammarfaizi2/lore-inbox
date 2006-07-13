Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030413AbWGMVh7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030413AbWGMVh7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 17:37:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030411AbWGMVh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 17:37:58 -0400
Received: from mail.kroah.org ([69.55.234.183]:1428 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1030410AbWGMVh5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 17:37:57 -0400
Date: Thu, 13 Jul 2006 14:22:01 -0700
From: Greg KH <greg@kroah.com>
To: Dave Jones <davej@redhat.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       fedora@adslpipe.co.uk
Subject: Re: strange kobject messages in .18rc1git3
Message-ID: <20060713212201.GB4218@kroah.com>
References: <20060712041642.GG32707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060712041642.GG32707@redhat.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2006 at 12:16:43AM -0400, Dave Jones wrote:
> Here's an odd suspend/resume regression reported by a Fedora user. (Andy Cc'd)
> 
> hub 4-0:1.0: resuming
> ac97 1-1:unknown codec: resuming
> usb 2-2: resuming
> hci_usb 2-2:1.0: resuming
> hci_usb 2-2:1.1: resuming
> platform bluetooth: resuming
> ACPI Exception (acpi_bus-0071): AE_NOT_FOUND, No context for object [c1deb4a4]
> [20060623]
> Restarting tasks...<6>usb 2-2: USB disconnect, address 2
> PM: Removing info for No Bus:usbdev2.2_ep81
> PM: Removing info for No Bus:usbdev2.2_ep02
> PM: Removing info for No Bus:usbdev2.2_ep82
> PM: Removing info for No Bus:hci0
>  done
> Thawing cpus ...
> 
> 
> kobject_add failed for vcs63 with -EEXIST, don't try to register things with the
> same name in the same directory.

Does the machine work properly after this message?

Looks like some bad issues with the console core :(

thanks,

greg k-h
