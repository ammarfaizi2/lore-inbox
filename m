Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263768AbUC3RrV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 12:47:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbUC3RrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 12:47:20 -0500
Received: from fmr06.intel.com ([134.134.136.7]:12501 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S263768AbUC3Rq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 12:46:29 -0500
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
From: Len Brown <len.brown@intel.com>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Willy Tarreau <willy@w.ods.org>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <4069A359.7040908@nortelnetworks.com>
References: <A6974D8E5F98D511BB910002A50A6647615F6939@hdsmsx402.hd.intel.com>
	 <1080535754.16221.188.camel@dhcppc4>
	 <20040329052238.GD1276@alpha.home.local> <1080598062.983.3.camel@dhcppc4>
	 <1080651370.25228.1.camel@dhcp23.swansea.linux.org.uk>
	 <Pine.LNX.4.53.0403300814350.5311@chaos>
	 <20040330142215.GA21931@alpha.home.local>
	 <Pine.LNX.4.53.0403300943520.6151@chaos>
	 <20040330150949.GA22073@alpha.home.local>
	 <Pine.LNX.4.53.0403301019570.6451@chaos>
	 <20040330161431.GA22272@alpha.home.local>
	 <4069A359.7040908@nortelnetworks.com>
Content-Type: text/plain
Organization: 
Message-Id: <1080668673.989.106.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 30 Mar 2004 12:44:33 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I didn't reply to this thread, after Alan wrote I figured
the topic was closed;-)

Yes, per my initial message, gcc _will_ generate cmpxchg for the 80386
build.  Indeed, it has been doing so for over a year with ACPI's
previous private (and flawed) asm() invocation of cmpxchg.

Andi/Alan suggested we invoke cmpxchg always in ACPI,
but disable ACPI at boot-time in the unlikely event we find
ourselves running on a cpu without that instruction.

Luming has already taking a swing at this patch here:
http://bugzilla.kernel.org/show_bug.cgi?id=2391

thanks,
-Len


