Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261777AbUK2TsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261777AbUK2TsO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 14:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbUK2TqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 14:46:01 -0500
Received: from mail.nea-fast.com ([66.35.146.201]:20967 "EHLO
	int1.nea-fast.com") by vger.kernel.org with ESMTP id S261765AbUK2Ton
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 14:44:43 -0500
Message-ID: <41AB7C2C.3070505@nea-fast.com>
Date: Mon, 29 Nov 2004 14:44:44 -0500
From: kernel <kernel@nea-fast.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040602
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 tcp problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger wrote:

> On Mon, 29 Nov 2004 13:03:34 -0500
> kernel <kernel@nea-fast.com> wrote:
>
>  
>
>> I've run into a problem with 2.6.(8.1,9) after installing a secondary 
>> firewall. When I try to pull data through the original firewall 
>> (mail, http, ssh), it stops after approx. 260k. Running ethereal 
>> tells me "A segment before the frame was lost" followed by a bunch 
>> of  "This is a TCP duplicate ack" when using ssh. All 2.4.x machines 
>> and windows clients work fine. I built 2.4.28 and it works fine from 
>> my machine. I also fiddled with tcp_ecn and that didn't fix it 
>> either. I don't have any problems communicating to "local" machines. 
>> I've attached the tcpdump output from an scp attempt. NIC is a 3Com 
>> Corporation 3c905B.
>>   
>
>
> What kind of firewall?  There are firewalls that are too stupid and don't
> understand TCP window scaling.
>
>  
>
It's a fortigate 60.  We put our secure web servers behind a netscreen 5 
firewall which plugs into the fortigate and that's when the problems 
started.  I remember reading some stuff on lkm about recent tcp changes 
but I couldn't remember exactly what it was. Thanks for reminding me !

Here is how it's layed out now
secure_web_servers->netscreen->fortigate->rest_of_network

Thanks !
walt

