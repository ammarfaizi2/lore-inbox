Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265966AbUG0OVF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUG0OVF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 10:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266052AbUG0OVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 10:21:05 -0400
Received: from posti6.jyu.fi ([130.234.4.43]:41945 "EHLO posti6.jyu.fi")
	by vger.kernel.org with ESMTP id S265966AbUG0OVC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 10:21:02 -0400
Date: Tue, 27 Jul 2004 17:20:18 +0300 (EEST)
From: Pasi Sjoholm <ptsjohol@cc.jyu.fi>
X-X-Sender: ptsjohol@silmu.st.jyu.fi
To: Robert Olsson <Robert.Olsson@data.slu.se>
cc: Francois Romieu <romieu@fr.zoreil.com>,
       H?ctor Mart?n <hector@marcansoft.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, <akpm@osdl.org>,
       <netdev@oss.sgi.com>, <brad@brad-x.com>, <shemminger@osdl.org>
Subject: Re: ksoftirqd uses 99% CPU triggered by network traffic (maybe
 RLT-8139 related)
In-Reply-To: <16646.14381.740376.204381@robur.slu.se>
Message-ID: <Pine.LNX.4.44.0407271710070.3787-100000@silmu.st.jyu.fi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Spam-Checked: by miltrassassin
	at posti6.jyu.fi; Tue, 27 Jul 2004 17:20:23 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004, Robert Olsson wrote:

>  > First run:
>  > timestamp diff = 0, maxlat = 4581159
>  Yes you starved your user apps for ~5 sec. 
>  Any idea where your load comes from? Pure NFS network load cannot be hard.

Yeah, when the ksoftirqd is taking all the cpu it will be like that, but 
when the kernel is behaving normally the starving diff is between 0->1sec.

With two samba-server-> workstation -> nfs-server file copys on the diff 
is normally 0.02secs if I'm not doing anything else but If I will do 
something cpu-intensive like compiling the kernel with "make -j3", the 
ksoftirqd will be soon taking all the cpu-time but this requires that I 
will also have those network file transfers going on.

--
Pasi Sjöholm



  


