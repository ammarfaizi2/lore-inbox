Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932119AbWFFHnn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbWFFHnn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 03:43:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWFFHnn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 03:43:43 -0400
Received: from mail1.kontent.de ([81.88.34.36]:9097 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932119AbWFFHnm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 03:43:42 -0400
From: Oliver Neukum <oliver@neukum.org>
To: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] USB devices fail unnecessarily on unpowered hubs
Date: Tue, 6 Jun 2006 09:43:58 +0200
User-Agent: KMail/1.8
Cc: linux-usb-devel@lists.sourceforge.net, Pavel Machek <pavel@suse.cz>,
       David Liontooth <liontooth@cogweb.net>, linux-kernel@vger.kernel.org
References: <447EB0DC.4040203@cogweb.net> <200606031129.54580.oliver@neukum.org> <200606050732.53496.david-b@pacbell.net>
In-Reply-To: <200606050732.53496.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606060943.59072.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 5. Juni 2006 16:32 schrieb David Brownell:
> On Saturday 03 June 2006 2:29 am, Oliver Neukum wrote:

> > If that does the job we need to somehow inherit the power supply maximum from
> > PCI when we allocate the root hub's device structure.
> 
> I don't think there is such a convention that's generic for PCI.  There might
> be ACPI-specific tables holding that value, but on embedded hardware the model
> is often that the arch/.../board-ZZZ.c file just "knows" things like how much
> power the regulator powering that port can provide, and arranges bus_mA to match.
> Just like it knows all sorts of other details about how that board works.

Yes, I am afraid it cannot be done on the fly. But we might use a symbolic
define which a subarch can override instead of a literal "500".
If it turns out that this problem is one of power and not some other
deficiency of this system's root hub.

	Regards
		Oliver
