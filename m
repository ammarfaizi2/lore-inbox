Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265531AbUGMRO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265531AbUGMRO2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 13:14:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265541AbUGMRO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 13:14:28 -0400
Received: from mail-relay-1.tiscali.it ([213.205.33.41]:60291 "EHLO
	mail-relay-1.tiscali.it") by vger.kernel.org with ESMTP
	id S265531AbUGMRO0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 13:14:26 -0400
Message-ID: <40F41866.2060305@eidetix.com>
Date: Tue, 13 Jul 2004 19:14:14 +0200
From: "David N. Welton" <davidw@eidetix.com>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040708)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ViCToRy <victory@piscue.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tcp connections dropped in 2.6.7
References: <40F411B6.10200@eidetix.com> <20040713170036.GD23026@piscue.com>
In-Reply-To: <20040713170036.GD23026@piscue.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ Please CC replies to me.  Thanks! ]

ViCToRy wrote:
> On Tue, Jul 13, 2004 at 06:45:42PM +0200, David N. Welton wrote:
> 
>>I'll put a dmesg up at http://dedasys.com/dmesg.txt
> 
> 
> Why eth1 goes to promiscuous mode? it's showed on last line of dmesg.

Because I tried tcpdump'ing ...

Server doesn't show packets arriving at all

Client shows things like this:

19:12:18.875723 IP coosbay.38062 > 192.168.0.240.ssh: S 
675525364:675525364(0) win 5840 <mss 1460,sackOK,timestamp 548888862 
0,nop,wscale 0>

19:12:18.878553 IP 192.168.0.240.ssh > coosbay.38062: R 0:0(0) ack 
675525365 win 0

Or

19:13:07.190788 IP coosbay.38063 > 192.168.0.240.www: S 
725915674:725915674(0) win 5840 <mss 1460,sackOK,timestamp 548937184 
0,nop,wscale 0>
19:13:07.196125 IP 192.168.0.240.www > coosbay.38063: R 0:0(0) ack 
725915675 win 0

yes, I tried it without the wscale... same thing.

I should also mention: 2.4.26 seems to have the same problem.

Thankyou,
-- 
David N. Welton
davidw@eidetix.com
