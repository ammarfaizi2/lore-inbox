Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261160AbVBQPv2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261160AbVBQPv2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Feb 2005 10:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262261AbVBQPv2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Feb 2005 10:51:28 -0500
Received: from fire.osdl.org ([65.172.181.4]:22243 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261160AbVBQPvU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Feb 2005 10:51:20 -0500
Message-ID: <4214BD6F.7080203@osdl.org>
Date: Thu, 17 Feb 2005 07:51:11 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
CC: Dale Blount <linux-kernel@dale.us>, linux-kernel@vger.kernel.org
Subject: Re: Oops in 2.6.10-ac12 in kjournald (journal_commit_transaction)
References: <20050215145618.GP24211@charite.de> <20050216153338.GA26953@atrey.karlin.mff.cuni.cz> <20050216200441.GH19871@charite.de> <1108590885.17089.17.camel@dale.velocity.net> <20050216145548.53f67fec.akpm@osdl.org> <20050217105818.GS6680@charite.de> <20050217132148.GE6680@charite.de>
In-Reply-To: <20050217132148.GE6680@charite.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ralf Hildebrandt wrote:
> * Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>:
> 
> 
>>>The best way to do that is to ensure that the kernel was built with
>>>CONFIG_DEBUG_INFO, note the offending EIP value, then do
>>>
>>># gdb vmlinux
>>>(gdb) l *0xc0<whatever>
>>
>>I'm rebuilding the ac12 kernel which crashed on me after just one day
>>and will reboot it today.
> 
> 
> Is it normal that the kernel with debugging enabled is not larger than
> the normal kernel?
> -

No, it should be much larger.  Recheck the .config file
for CONFIG_DEBUG_INFO=y.  Maybe you need to do 'make clean'
first.

-- 
~Randy
