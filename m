Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267343AbUHDQ1f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267343AbUHDQ1f (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 12:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267347AbUHDQ1e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 12:27:34 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:18652 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S267344AbUHDQ0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 12:26:32 -0400
Date: Wed, 4 Aug 2004 19:26:03 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: Francois Romieu <romieu@fr.zoreil.com>
cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <Pine.LNX.4.44.0408032256110.2281-100000@silmu.st.jyu.fi>
Message-ID: <Pine.LNX.4.44.0408041915510.14609-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Wed, 04 Aug 2004 19:26:09 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Aug 2004, Pasi Sjoholm wrote:

> > If you remove the "if (received > 0) {" test in r8139-10.patch and keep
> > both patches applied, I assume you are back to a crash within 15min (instead
> > of within 2min as suggested by the log), right ?
> I removed "if (received > 0) {" and tested it something like 3 hours and 
> wasn't able to crash the driver. I will test it for couple more hours 
> tomorrow and if I'm not still able the crash it, we may have find some 
> sort of a solution.
> I'm not sure yet if it's a good one because of that earlier crash I had.
> I guess I will also test if
> "- read the interruption status word that the driver will ack before the
>   actual processing is done;" has something to do with it.

Ok, now I have tested it for 6 hours without crashing the driver. The 
system's load has been something like 5-6 the whole time. I also made some 
network load with ~90Mbps-incoming and ~90Mbps-outgoing traffic. 

I haven't had time to test anything else but I'm quite sure that there is 
no need for that anymore because the stability we have reached. 

I'll let you know if there's any problems within next few days but I would 
recommend that those patches would be included in 2.6.8. (without that "if 
(received > 0) {").

Many thanks for your help to resolve this problem. 

Hector, have you tested these patches?

--
Pasi Sjöholm


