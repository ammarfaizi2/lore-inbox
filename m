Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261961AbUC0WUa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Mar 2004 17:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbUC0WUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Mar 2004 17:20:30 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61873 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261961AbUC0WU3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Mar 2004 17:20:29 -0500
Message-ID: <4065FE19.4010103@pobox.com>
Date: Sat, 27 Mar 2004 17:20:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Henrik Gustafsson <lkml@fnord.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: [sata] libata update
References: <opr5jjrhylesu439@mail1.telia.com>
In-Reply-To: <opr5jjrhylesu439@mail1.telia.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrik Gustafsson wrote:
> (sorry for screwing with the thread, I was not subscribed when I read 
> the original post)
> 
> The patch seems to work just fine. It's been running for six hours now 
> with varying amounts of load and no catastrophes has occurred so far.
> 
> Only things are these lines saying 'abnormal status' (which has been 
> there all along). I assume the codes mean 'device not present' (which 
> would be correct, at least in my case) or something similar, but I don't 
> know for sure so I leave it to someone better informed to patch :)
> 
> (also, there is the 'Unknown device'-thing in my lspci, but that's 
> neither related to libata nor is it a 'real' problem)
> 
> Using a Promise FastTrack S150 SX4
> Relevant piece of my dmesg, lspci follows (just let me know if you need 
> the rest)

Thanks for testing.

Yes, the SX4, unlike the TX2/TX4, does not directly give me access to 
the SATA ports, so I cannot test directly for device presence.  Instead 
I let the normal error handling routines notice the behavior.  I need to 
fix that up, but for now that's an annoying but harmless message.

	Jeff




