Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbUC3UDO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 15:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbUC3UDO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 15:03:14 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:20612 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261181AbUC3UDJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 15:03:09 -0500
Message-ID: <4069D3D2.2020402@tmr.com>
Date: Tue, 30 Mar 2004 15:08:50 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Chris Friesen <cfriesen@nortelnetworks.com>,
       Willy Tarreau <willy@w.ods.org>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
References: <4069A359.7040908@nortelnetworks.com> <1080668673.989.106.camel@dhcppc4>
In-Reply-To: <1080668673.989.106.camel@dhcppc4>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> Sorry I didn't reply to this thread, after Alan wrote I figured
> the topic was closed;-)
> 
> Yes, per my initial message, gcc _will_ generate cmpxchg for the 80386
> build.  Indeed, it has been doing so for over a year with ACPI's
> previous private (and flawed) asm() invocation of cmpxchg.
> 
> Andi/Alan suggested we invoke cmpxchg always in ACPI,
> but disable ACPI at boot-time in the unlikely event we find
> ourselves running on a cpu without that instruction.

Is there no reasonable way to avoid using it in ACPI? It's not as if 
performance was critical there, or the code gets run often. Too bad it 
can't just be emulated like floating point, but I don't think it can on SMP.

I have to think Alan is right as usual.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
