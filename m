Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271055AbUJUWvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271055AbUJUWvQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 18:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271037AbUJUWsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 18:48:17 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:3249 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S271020AbUJUWhJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 18:37:09 -0400
Message-ID: <417839F6.7090308@nortelnetworks.com>
Date: Thu, 21 Oct 2004 16:36:38 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
CC: george@mvista.com, root@chaos.analogic.com,
       "Brown, Len" <len.brown@intel.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: gradual timeofday overhaul
References: <F989B1573A3A644BAB3920FBECA4D25A011F96DC@orsmsx407>
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A011F96DC@orsmsx407>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky wrote:

> Now, the ugly case would be if number_of_context_swiches_per_second > HZ.
> In HZ = 100, this could be happening, but in HZ=1000, in a single CPU
> ...well, that would be TOO weird [of course, a real-time app with a 
> 1ms period would do that, but it'd require at least an HZ of 10000 to
> work more or less ok and we'd be below the watermark].

It's easy to have >>1000 context switches per second on a server.  Consider a 
web server that receives a network packet, issues a request to a database, hands 
some work off to a thread so the main app doesn't block, then sends a response. 
  That could be a half dozen context switches per packet.  If you have 20000 
packets/sec coming in....


Chris
