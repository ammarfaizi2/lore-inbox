Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261276AbTLLRNo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 12:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261326AbTLLRNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 12:13:44 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:42209 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261276AbTLLRNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 12:13:43 -0500
Message-ID: <3FD9F72C.6040401@nortelnetworks.com>
Date: Fri, 12 Dec 2003 12:13:16 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: campbell@accelinc.com
Cc: Jamie Lokier <jamie@shareable.org>, Helge Hafting <helgehaf@aitel.hist.no>,
       =?ISO-8859-1?Q?M=E5ns=20Rullg=E5rd?= <mru@kth.se>,
       linux-kernel@vger.kernel.org
Subject: Re: udev sysfs docs Re: State of devfs in 2.6?
References: <3FD4CC7B.8050107@nishanet.com> <20031208233755.GC31370@kroah.com> <20031209061728.28bfaf0f.witukind@nsbm.kicks-ass.org> <20031209075619.GA1698@kroah.com> <1070960433.869.77.camel@nomade> <20031209090815.GA2681@kroah.com> <buoiskqfivq.fsf@mcspd15.ucom.lsi.nec.co.jp> <yw1xd6ayib3f.fsf@kth.se> <3FD5AB6C.3040008@aitel.hist.no> <20031212112636.GA12727@mail.shareable.org> <20031212163422.GA4051@helium.inexs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Campbell wrote:
> On Fri, Dec 12, 2003 at 11:26:36AM +0000, Jamie Lokier wrote:
> 
>>If anyone wants to do this _properly_, this is what to do:
>>
>>
> 
> I might have missed something, but this is only for modular devices right?

Depends on what you mean by "this".

> No application to devices compiled in monolithically?

As devices are detected, hotplug is called (which then calls udev), and 
udev finds the new entries in /sys and adds the appropriate nodes in 
/dev.  Completely separate from udev, the hotplug framework also loads 
the module if the driver is not compiled-in.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

