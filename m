Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270201AbTGWLi4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jul 2003 07:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270210AbTGWLi4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jul 2003 07:38:56 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:10706 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S270201AbTGWLiw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jul 2003 07:38:52 -0400
Message-ID: <3F1E7760.1000909@softhome.net>
Date: Wed, 23 Jul 2003 13:54:08 +0200
From: "Ihar \"Philips\" Filipau" <filia@softhome.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jimis@gmx.net
CC: linux-kernel@vger.kernel.org
Subject: Re: Feature proposal (scheduling related)
References: <cpvY.4hH.25@gated-at.bofh.it>
In-Reply-To: <cpvY.4hH.25@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jimis@gmx.net wrote:
> With the current scheduler we can prioritize the CPU usage for each 
> process. What I think would be extremely useful (as I have needed it 
> many times) is the scheduling of disk I/O and net I/O traffic. 2 
> examples showing the importance (the numbers are estimations just to 
> explain whati I mean):
> 

    can address only your first problem.

> 1)I 'm connected to the internet via dial-up, therefore I only have 40 
> kbits of bandwidth available. What I want to do is listen to icecast 
> radio via xmms (at 22 kbits), download the kernel sources with wget, and 
> browse the web at the same time. Currently I think that this is 
> *impossible* (correct me if I'm wrong) as the radio will be full of 
> pauses and the browsing experience painfully slow. What I would like to 
> be able to do (let's suppose nice has the --net option to set net I/O 
> priority):
> $ nice --net -1 xmms
> $ nice --net 1 wget ftp://.../KernelSources.tar.bz2
> $ mozilla
> This way, xmms which has top priority whould always get the 22kbits it 
> needs. What remains should go to the browser when I ask for a web page, 
> and when the browser doesn't request anything (let's say I'm reading a 
> big doc in tldp) what remains should go to wget. Wget has lower priority 
> and won't irritate the browsing experience, though the file will be 
> downloaded when there is free bandwidth.
> 

    this is already in kernel and called Quality of Service (QoS) or 
traffic shaping.
    command is called /sbin/tc. (located in iproute.rpm in RH)
    instead of man page (because there is no man page) I can recommend 
to look in Internet.
    e.g. http://users.belgacom.net/staf/ -> QoS intro
    also you can try to "rpm -ql $(which tc)" - probably your distor has 
some docs.

