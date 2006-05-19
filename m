Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbWESART@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbWESART (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 20:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbWESART
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 20:17:19 -0400
Received: from mail.unixshell.com ([207.210.106.37]:54694 "EHLO
	mail.unixshell.com") by vger.kernel.org with ESMTP id S932133AbWESARS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 20:17:18 -0400
Message-ID: <446D0E6D.2080600@tektonic.net>
Date: Thu, 18 May 2006 20:16:45 -0400
From: Matt Ayres <matta@tektonic.net>
Organization: TekTonic
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: James Morris <jmorris@namei.org>
CC: "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Patrick McHardy <kaber@trash.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: Panic in ipt_do_table with 2.6.16.13-xen
References: <4468BE70.7030802@tektonic.net> <4468D613.20309@trash.net> <44691669.4080903@tektonic.net> <Pine.LNX.4.64.0605152331140.10964@d.namei> <4469D84F.8080709@tektonic.net> <Pine.LNX.4.64.0605161127030.16379@d.namei> <446D0A0D.5090608@tektonic.net> <Pine.LNX.4.64.0605182002330.6528@d.namei>
In-Reply-To: <Pine.LNX.4.64.0605182002330.6528@d.namei>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



James Morris wrote:
> On Thu, 18 May 2006, Matt Ayres wrote:
> 
>>> I'm trying to suggest eliminating this driver & possible interaction with
>>> Xen network changes as a cause.  If you can find a different type of NIC to
>>> plug in and use, or even try and change all of the params for the tg3 with
>>> ethtool, it'll help.
>>>
>> Hi,
>>
>> Thank you for the assistance. Which parameters do you suggest changing?
>> TSO/flow control off?
> 
> Yep, anything.

Ok, "ethtool -K eth0 rx off tx off sg off tso off" should have turned it 
  all off.

> 
>> iptables -L -v just shows 2 rules per Virtual Machine for accounting. This
>> averages about 100 rules in the FORWARD chain.  Example:
> 
> Do you know if the problem starts appearing after a certain number of 
> hosts?
> 

No... I have some servers that are running just 2.6.16-xen (no bugfix 
patches) for 30 days without a problem, some of these have rulesets 
larger than the ones that crash daily. I'd estimate this affects 90% of 
my servers, just some reboot daily and others can make it to 7-10 days.

Thanks,
Matt

