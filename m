Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261567AbVEJHTp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261567AbVEJHTp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 03:19:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261568AbVEJHTo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 03:19:44 -0400
Received: from nwkea-mail-2.sun.com ([192.18.42.14]:8940 "EHLO
	nwkea-mail-2.sun.com") by vger.kernel.org with ESMTP
	id S261567AbVEJHTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 03:19:38 -0400
Date: Tue, 10 May 2005 11:19:32 +0400
From: Mitch <Mitch@0Bits.COM>
Subject: Re: ALPS testers wanted (Was Re: [RFT/PATCH] KVMS,
 mouse losing sync and going crazy)
To: dtor_core@ameritech.net, linux-kernel@vger.kernel.org
Message-id: <42806084.4010205@0Bits.COM>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Mail/News Client 1.0+ (X11/20050427)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dimitry,

No go with the patch, and even with patch and uncommenting the 
ps2_drain(). The alps touchpad is dead as a dodo.

Cheers
Mitch

-------- Original Message --------
Subject: ALPS testers wanted (Was Re: [RFT/PATCH] KVMS, mouse losing 
sync and going crazy)
Date: Mon, 9 May 2005 23:03:46 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Mitch <Mitch@0Bits.COM>
CC: linux-kernel@vger.kernel.org
References: <427F09C1.8010703@0Bits.COM>

On Monday 09 May 2005 01:57, Mitch wrote:
> Hi Dmitry,
> 
> No, no change with the attached patch either. Mouse goes to sleep and 
> need to be re-enabled constantly.
> 

Hi Mitch,

OK, here is an updated patch. Hopefully if we toggle passthrough mode on
Dualpoints we will get an absolute packet in response to POLL command.

Please give it a try. If it does not work please try uncommenting call to
ps2_drain in drivers/input/mouse/alps.c::alps_passthrough_mode().

Thanks!

-- 
Dmitry

http://www.geocities.com/dt_or/input/2_6_11/psmouse-resync-2.6.11-v6.patch.gz


