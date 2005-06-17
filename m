Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261520AbVFQWx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261520AbVFQWx4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 18:53:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVFQWvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 18:51:25 -0400
Received: from sj-iport-2-in.cisco.com ([171.71.176.71]:51210 "EHLO
	sj-iport-2.cisco.com") by vger.kernel.org with ESMTP
	id S262028AbVFQWun (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 18:50:43 -0400
Message-ID: <42B353B7.4070503@cisco.com>
Date: Sat, 18 Jun 2005 08:50:31 +1000
From: Lincoln Dale <ltd@cisco.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Valdis.Kletnieks@vt.edu
CC: abonilla@linuxwireless.org, "'Lars Roland'" <lroland@gmail.com>,
       "'Christian Kujau'" <evil@g-house.de>,
       "'Linux-Kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: tg3 in 2.6.12-rc6 and Cisco PIX SMTP fixup
References: <001f01c57341$1802c3b0$600cc60a@amer.sykes.com> <200506171352.j5HDqpE8006543@turing-police.cc.vt.edu>
In-Reply-To: <200506171352.j5HDqpE8006543@turing-police.cc.vt.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

>On Fri, 17 Jun 2005 07:33:05 MDT, Alejandro Bonilla said:
>
>  
>
>>	So what do we really have here? Problem with Cisco or a problem in the
>>driver? Both?
>>    
>>
>
>The Cisco PIX is gratuitously clearing the TCP window scaling bits.  So if you
>have tcp_adv_win_scale set to (for example) 6, you'll send a window advertisement
>of (say) 4096, represented as 64 and a "shift left 6 bits".  The PIX whacks the
>"6 bits" part, and the other end thinks the window is 64 bytes and wedges when
>a response is over 64 bytes long.
>
>  
>
there _was_ a bug in the Cisco PIX whereby it cleared TCP window-scaling 
bits.
this can be tracked through cisco bug-id CSCdy29514.

this was fixed back in August 2002 with the fix incorporated into PIX 
software releases 6.1.5 and 6.2.3 and later.
any 'recent' (i.e. last 2.5 years) releases don't have this problem. 
(or, at least, we don't think so..).


cheers,

lincoln.
