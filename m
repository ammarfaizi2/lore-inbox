Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751317AbWI3Rei@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbWI3Rei (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 13:34:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWI3Reh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 13:34:37 -0400
Received: from khc.piap.pl ([195.187.100.11]:30139 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751317AbWI3Reh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 13:34:37 -0400
To: Ben Greear <greearb@candelatech.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Question on HDLC and raw access to T1/E1 serial streams.
References: <451DC75E.4070403@candelatech.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sat, 30 Sep 2006 19:34:33 +0200
In-Reply-To: <451DC75E.4070403@candelatech.com> (Ben Greear's message of "Fri, 29 Sep 2006 18:24:46 -0700")
Message-ID: <m3mz8hntqu.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear <greearb@candelatech.com> writes:

> I am looking for a way to bridge a T1/E1 network by reading a raw
> bitstream from one T1 interface and writing it out to the other.  The
> application is adding delay and/or bit corruptions for impairment
> testing.
>
> I have been using Sangoma's drivers and NICs, but I'm having no luck
> getting their latest stuff to work so I was hoping to use in-kernel
> drivers (even if that means writing or hiring someone to write new ones.)
>
> Is there currently a way to read/write the raw bitstream for a full T1
> or E1 or a subset of channels?

Well, my generic HDLC works with HDLC framing only, T1/E1 is
a layer lower than that... I think Cyclades have (had?) a version
of PC300 card with T1/E1 interface. It at least doesn't require
any "binary blobs", though I think the driver would need some work.

Which line interface do you need? G.703?
Do you need to bridge multiple streams (not slots) over one
interface (internal (de)multiplexer - I mean "more than one
subset of channels")?
-- 
Krzysztof Halasa
