Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbTD2L2m (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 07:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261609AbTD2L2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 07:28:42 -0400
Received: from main.gmane.org ([80.91.224.249]:43221 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261598AbTD2L2l (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 07:28:41 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <dragon@gentoo.org>
Subject: Re: 2.4.21-rc1-ac3: unresolved symbol only with gcc-3.3
Date: Tue, 29 Apr 2003 07:35:32 -0400
Message-ID: <3EAE6384.3050702@gentoo.org>
References: <20030429104434.GA19733@neon.pearbough.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Axel Siebenwirth wrote:
> Hi,
> 
> today I have successfully built 2.4.21-rc1-ac3 with gcc-3.2.3. Everything
> was fine.
> Then I built with gcc-3.3 and I encountered an error:
> 
> net/network.o(.text+0xdcd7): In function `rtnetlink_rcv':
> : undefined reference to `rtnetlink_rcv_skb'
> 
> This build error only occurs with gcc-3.3.
> 
> Can somebody who knows the kernel look whether the error is legitimate or 
> gcc is making errors.

I'm not sure if this is necessarily the right way, but 
changing the declaration for rtnetlink_rcv_skb() in 
net/core/rtnetlink.c from "extern" to "static" seems to have 
fixed the problem for me.  In any case, I couldn't find any 
external references to that function, so it seems to me that 
this is the way to go.

Cheers,
Nicholas


