Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTLYRwA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Dec 2003 12:52:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264337AbTLYRwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Dec 2003 12:52:00 -0500
Received: from main.gmane.org ([80.91.224.249]:483 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S264334AbTLYRv7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Dec 2003 12:51:59 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: Re: allow process or user to listen on priviledged ports?
Date: Thu, 25 Dec 2003 18:46:10 +0100
Message-ID: <bsf83s$f23$1@sea.gmane.org>
References: <bscg1m$1eg$1@sea.gmane.org> <20031225104526.GA10239@axis.demon.co.uk> <3FEAD582.10908@upb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4.1) Gecko/20031008
X-Accept-Language: de, en
In-Reply-To: <3FEAD582.10908@upb.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I would give your application this capability (from #include 
>> "linux/capability.h")
>>
>>   /* Allows binding to TCP/UDP sockets below 1024 */
>>   /* Allows binding to ATM VCIs below 32 */
>>
>>   #define CAP_NET_BIND_SERVICE 10
>>
>> You do this with a setuid wrapper which drops all capabilities but
>> that one and then runs your application.
> 
> Thx for the answer! That's exactly what i search for.

Unfortunatly my gladness didn't last long. The FAQ at
http://ftp.kernel.org/pub/linux/libs/security/linux-privs/kernel-2.4/capfaq-0.2.txt 
states that CAP_SETPCAP is disabled, but it doesn't say why it is 
disapled. That capability is needed by sucap to work.

So why is CAP_SETPCAP disabled by default?


