Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262651AbVCJAok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262651AbVCJAok (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 19:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262586AbVCJAfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 19:35:46 -0500
Received: from www.rapidforum.com ([80.237.244.2]:147 "HELO rapidforum.com")
	by vger.kernel.org with SMTP id S262583AbVCJAY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 19:24:57 -0500
Message-ID: <422F93CE.3060403@rapidforum.com>
Date: Thu, 10 Mar 2005 01:24:46 +0100
From: Christian Schmid <webmaster@rapidforum.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: de, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-kernel@vger.kernel.org
Subject: Re: BUG: Slowdown on 3000 socket-machines tracked down
References: <4229E805.3050105@rapidforum.com> <422BAAC6.6040705@candelatech.com> <422BB548.1020906@rapidforum.com> <422BC303.9060907@candelatech.com> <422BE33D.5080904@yahoo.com.au> <422C1D57.9040708@candelatech.com> <422C1EC0.8050106@yahoo.com.au> <422D468C.7060900@candelatech.com> <422DD5A3.7060202@rapidforum.com> <422F8A8A.8010606@candelatech.com> <422F8C58.4000809@rapidforum.com> <422F9259.2010003@candelatech.com>
In-Reply-To: <422F9259.2010003@candelatech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So, maybe a VM problem?  That would be a good place to focus since
> I think we can be fairly certain it isn't a problem in just the
> networking code.  Otherwise, my tests would show lower bandwidth.

Thanks to your tests I am really sure that its no network-code problem anymore. But what I THINK it 
is: The network is allocating buffers dynamically and if the vm doesnt provide that buffers fast 
enough, it locks as well. Addendum: If I throttle to 100 MBit it doesnt slow-down even with 5000 
sockets. What do you think? I think its about having to free cache more quicker than possible. But 
then, why is CPU still at 30%? Might there be some limit per cyclus? For example if that "cleaner" 
wakes up every 10 ms and cleans max XXXXX pages, it would explain an artificial limit.

Chris

