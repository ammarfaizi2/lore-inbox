Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424978AbWLHHPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424978AbWLHHPP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Dec 2006 02:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424982AbWLHHPP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 02:15:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:36229 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1424978AbWLHHPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 02:15:13 -0500
Date: Thu, 7 Dec 2006 23:14:37 -0800
From: Greg KH <gregkh@suse.de>
To: "Lu, Yinghai" <yinghai.lu@amd.com>
Cc: ebiederm@xmission.com, Peter Stuge <stuge-linuxbios@cdy.org>,
       linux-usb-devel@lists.sourceforge.net,
       Stefan Reinauer <stepan@coresystems.de>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org, Andi Kleen <ak@suse.de>,
       David Brownell <david-b@pacbell.net>
Subject: Re: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
Message-ID: <20061208071437.GA23173@suse.de>
References: <5986589C150B2F49A46483AC44C7BCA49072A5@ssvlexmb2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5986589C150B2F49A46483AC44C7BCA49072A5@ssvlexmb2.amd.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2006 at 07:48:17PM -0800, Lu, Yinghai wrote:
> With Greg's USB Debug, host and target can talk.
> target with console=ttyUSB0,115200n8

Ugh, no, never use the usb-serial driver as a console device.

That was a bad hack done as a bet many years ago.  For many obvious
reasons it does not work well.

> host with cat /dev/ttyUSB0
> But if use minicom in host, it will not show '\r', I guess the usb debug
> cable eat return char. Greg, Can you add that back in usb_debug by
> replacing '\n' with '\r', '\n'?

The usb-serial console code should handle this, I thought we fixed it a
while ago.

But this kind of interface is not what these devices are good for.  They
are for the debug port information, not as a usb-serial console device.
Otherwise they are way too expensive of a device...

thanks,

greg k-h
