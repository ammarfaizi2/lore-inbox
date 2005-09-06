Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964995AbVIFAU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964995AbVIFAU6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 20:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVIFAU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 20:20:58 -0400
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:30596 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S964995AbVIFAU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 20:20:57 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] Change behaviour of psmouse-base.c under error conditions.
Date: Mon, 5 Sep 2005 19:20:40 -0500
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, "Bryan O'Donoghue" <typedef@eircom.net>
References: <431CB166.40904@eircom.net> <200509051612.14180.dtor_core@ameritech.net> <20050905215512.GB12252@midnight.suse.cz>
In-Reply-To: <20050905215512.GB12252@midnight.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509051920.40482.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 05 September 2005 16:55, Vojtech Pavlik wrote:
> On Mon, Sep 05, 2005 at 04:12:13PM -0500, Dmitry Torokhov wrote:
> > On Monday 05 September 2005 15:58, Bryan O'Donoghue wrote:
> > > 
> > > However, the KVM in question invariably ends up sending a packet like this
> > > 
> > > packet= 0x0 0xff 0x2 0x8
> > > 
> > > Which is completely invalid for PS/2 and IMPS/2, the specification of
> > > PS/2 defines bit 4 in byte 0 as always being 1.
> 
> Just for the record: Bit 4 was supposed to indicate an external (=1)
> mouse, while internal mice would have a '0' there. This then would allow
> to differentiate between two devices on the same bus.
> 
> I've even seen that in action on one very old laptop.
> 
> Of course, extended protocols break that completely.

IBM Trackpoint controllers can force that bit to 1 for internal device
and to 0 for external. If we ever implement pass-through port for
trackpoints we might use it do demultiplex data streams.

-- 
Dmitry
