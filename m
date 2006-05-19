Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932148AbWESApv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932148AbWESApv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 20:45:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWESApv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 20:45:51 -0400
Received: from mail.unixshell.com ([207.210.106.37]:30613 "EHLO
	mail.unixshell.com") by vger.kernel.org with ESMTP id S932148AbWESApv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 20:45:51 -0400
Message-ID: <446D151D.6030307@tektonic.net>
Date: Thu, 18 May 2006 20:45:17 -0400
From: Matt Ayres <matta@tektonic.net>
Organization: TekTonic
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Matt Ayres <matta@tektonic.net>
CC: James Morris <jmorris@namei.org>,
       "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>,
       Netfilter Development Mailinglist 
	<netfilter-devel@lists.netfilter.org>,
       Patrick McHardy <kaber@trash.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Xen-devel] Re: Panic in ipt_do_table with 2.6.16.13-xen
References: <4468BE70.7030802@tektonic.net> <4468D613.20309@trash.net>	<44691669.4080903@tektonic.net>	<Pine.LNX.4.64.0605152331140.10964@d.namei>	<4469D84F.8080709@tektonic.net>	<Pine.LNX.4.64.0605161127030.16379@d.namei>	<446D0A0D.5090608@tektonic.net>	<Pine.LNX.4.64.0605182002330.6528@d.namei> <446D0E6D.2080600@tektonic.net>
In-Reply-To: <446D0E6D.2080600@tektonic.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Matt Ayres wrote:
> 
> 
> James Morris wrote:
>> On Thu, 18 May 2006, Matt Ayres wrote:
>>
>>>> I'm trying to suggest eliminating this driver & possible interaction 
>>>> with
>>>> Xen network changes as a cause.  If you can find a different type of 
>>>> NIC to
>>>> plug in and use, or even try and change all of the params for the 
>>>> tg3 with
>>>> ethtool, it'll help.
>>>>
>>> Hi,
>>>
>>> Thank you for the assistance. Which parameters do you suggest changing?
>>> TSO/flow control off?
>>
>> Yep, anything.
> 
> Ok, "ethtool -K eth0 rx off tx off sg off tso off" should have turned it 
>  all off.
> 

I think I confirmed the NIC is not the source of the problem.  A few of 
my servers have e100/tulip NIC's due to a bug with the chipset of the 
on-board TG3 cards firmware and TSO.  These servers that use the 
e100/tulip drivers also experience the ipt_do_table bug.

Thanks,
Matt
