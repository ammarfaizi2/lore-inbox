Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261702AbVDELrJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261702AbVDELrJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 07:47:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261701AbVDELrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 07:47:08 -0400
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:53667 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S261703AbVDELqA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 07:46:00 -0400
Date: Tue, 5 Apr 2005 07:45:43 -0400
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Jan Harkes <jaharkes@cs.cmu.edu>, Greg KH <greg@kroah.com>,
       Sven Luther <sven.luther@wanadoo.fr>,
       Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
       debian-kernel@lists.debian.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/04] Load keyspan firmware with hotplug
Message-ID: <20050405114543.GG10171@delft.aura.cs.cmu.edu>
Mail-Followup-To: Marcel Holtmann <marcel@holtmann.org>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	Jan Harkes <jaharkes@cs.cmu.edu>, Greg KH <greg@kroah.com>,
	Sven Luther <sven.luther@wanadoo.fr>,
	Michael Poole <mdpoole@troilus.org>, debian-legal@lists.debian.org,
	debian-kernel@lists.debian.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050404100929.GA23921@pegasos> <20050404191745.GB12141@kroah.com> <20050405042329.GA10171@delft.aura.cs.cmu.edu> <200504042351.22099.dtor_core@ameritech.net> <1112692926.8263.125.camel@pegasus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112692926.8263.125.camel@pegasus>
User-Agent: Mutt/1.5.6+20040907i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2005 at 11:22:06AM +0200, Marcel Holtmann wrote:
> I agree with Dmitry on this point. The IHEX parser should not be inside
> firmware_class.c. What about using keyspan_ihex.[ch] for it?

That's what I had originally, actually called firmware_ihex.ko, since
the IHEX format parser is not in any way keyspan specific and there are
several usb-serial converters that seem to use the same IHEX->.h trick
which could trivially be modified to use this loader.

But the compiled parser fairly small (< 2KB) and adding it to the
existing module didn't effectively add any size to the firmware_class
module since things are rounded to a page boundary anyways.

Jan

