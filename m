Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261238AbVBPAps@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVBPAps (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 19:45:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbVBPAps
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 19:45:48 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:58247 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261238AbVBPApn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 19:45:43 -0500
From: Jesse Barnes <jbarnes@sgi.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] quiet non-x86 option ROM warnings
Date: Tue, 15 Feb 2005 16:45:27 -0800
User-Agent: KMail/1.7.2
Cc: akpm@osdl.org, benh@kernel.crashing.org, linux-kernel@vger.kernel.org
References: <200502151557.06049.jbarnes@sgi.com> <9e473391050215163621dafa65@mail.gmail.com>
In-Reply-To: <9e473391050215163621dafa65@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502151645.27774.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, February 15, 2005 4:36 pm, Jon Smirl wrote:
> You're removing the check for 55AA at the start of the ROM.

No, the check is still there, I just removed the printk if 0xaa55 isn't found 
(my box returns 0x303 instead).

> I though 
> the PCI standard was that all ROMs had to start with the no matter
> what object code they contain. Then if you look for PCIR there is a
> field in the stucture that says what language the ROM is in. Maybe the
> problem is in the BIOS_IN16() function and things are getting byte
> swapped wrong.

I thought the signature described what type of ROM was there?  E.g. 0xaa55 
means x86 ROM, x0303 means OF ROM, etc.?

At any rate, not having a ROM at all (which my case may be) isn't an error 
either, so I think removing the printk is appropriate regardless.

Thanks,
Jesse
