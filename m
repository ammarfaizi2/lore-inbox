Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262281AbSIZKnK>; Thu, 26 Sep 2002 06:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262283AbSIZKnK>; Thu, 26 Sep 2002 06:43:10 -0400
Received: from adsl-196-233.cybernet.ch ([212.90.196.233]:36317 "HELO
	mailphish.drugphish.ch") by vger.kernel.org with SMTP
	id <S262281AbSIZKnK>; Thu, 26 Sep 2002 06:43:10 -0400
Message-ID: <3D92E636.1010404@drugphish.ch>
Date: Thu, 26 Sep 2002 12:49:26 +0200
From: Roberto Nibali <ratz@drugphish.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, niv@us.ibm.com, linux-kernel@vger.kernel.org, hadi@cyberus.ca
Subject: Re: [ANNOUNCE] NF-HIPAC: High Performance Packet Classification
References: <3D92CCC5.5000206@drugphish.ch>	<20020926.020602.75761707.davem@redhat.com>	<3D92E090.4030504@drugphish.ch> <20020926.032031.76775895.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What if the netconsole packets cause events to be logged?

Oups! Well, you could send them via printk to the internal printk buffer 
which then gets fetched by the local syslog and then you can decide what 
to do since those messages should never fill up the buffer as quickly as 
syslog will be able to get them. Actually then you should rate limit the 
printk messages and probably also increase the buffer size.

But to be honest, those are not the usual messages that fill up the 
buffer so fast that syslog is not able to read the message before the 
buffer gets overwritten again. Of course you will then have a logfile 
inconsistency and this could be accounted just as well as a loss of trace.

But generally I agree that you're standing there pants down. For example 
if you have a filter rule in the routing or whereever code that doesn't 
permit the packets to leave the machine and thus to be dropped. Ah well 
... it was worth a try.

[Hmpf, my collegue is just testing this right now but I think I can then 
tell him to stop this because you're always biting your own tail with 
this approach, one way or another].

Thanks for the valuable input and best regards,
Roberto Nibali, ratz
-- 
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb3135071790101768542287578439snlbxq'|dc

