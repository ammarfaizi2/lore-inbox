Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261841AbTCaUip>; Mon, 31 Mar 2003 15:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbTCaUio>; Mon, 31 Mar 2003 15:38:44 -0500
Received: from CPE0080c8c9b431-CM014280010574.cpe.net.cable.rogers.com ([24.114.72.97]:2314
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id <S261841AbTCaUin>; Mon, 31 Mar 2003 15:38:43 -0500
Subject: Re: hdparm and removable IDE?
From: Jeremy Jackson <jerj@coplanar.net>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Ron House <house@usq.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.3.96.1030331140112.32749A-100000@gatekeeper.tmr.com>
References: <Pine.LNX.3.96.1030331140112.32749A-100000@gatekeeper.tmr.com>
Content-Type: text/plain
Organization: 
Message-Id: <1049143734.1258.46.camel@contact.skynet.coplanar.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 31 Mar 2003 15:48:54 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-31 at 14:14, Bill Davidsen wrote:
> > IDE bus to disconnect/*reconnect*?) But hot swap will always affect both
> > cables.
> 
> Boy I hope that's a typo... I hope you meant both devices on a cable and
> not really both cables on a controller.

Yep, sorry.  The IDE controller must tri-state off an entire cable...
both devices.  I guess you could have 2 devices, and swap one but leave
the other, you just have to halt all IO durring the swap, perhaps reset
both devices when the cable is switched back on.

Interesting to note, Intel's PIIX (forget what version) had a feature
that would split the primary cable (from the OS point of view - think
dos here) so the master was on the primary cable, and the slave was on
the secondary cable.  each device (ie swap bay in a laptop) could be
tristated separately.  of course you loose the secondary channel.
-- 
Jeremy Jackson <jerj@coplanar.net>

