Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261801AbULUQlj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbULUQlj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 11:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbULUQjv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 11:39:51 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:48774 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261795AbULUQj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 11:39:27 -0500
Message-ID: <41C85216.1070304@tmr.com>
Date: Tue, 21 Dec 2004 11:40:54 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: 7eggert@gmx.de
CC: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9 NAT problem
References: <fa.b00sk8v.12lus29@ifi.uio.no> <E1CgfT5-0000Zh-00@be1.7eggert.dyndns.org>
In-Reply-To: <E1CgfT5-0000Zh-00@be1.7eggert.dyndns.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bodo Eggert wrote:
> Bill Davidsen wrote:
> 
>>Antonio Pérez wrote:
> 
> 
>>>add this:
>>>echo 0 > /proc/sys/net/ipv4/tcp_bic
>>>echo 0 > /proc/sys/net/ipv4/tcp_ecn
>>>echo 0 > /proc/sys/net/ipv4/tcp_vegas_conf_avoid
>>
>>I've seen this and similar advice for other problems, and have disabled=
>> 
>>ecn for several systems with networking ailments myself. Would it be
>>better to have some of these off by default rather than have multiple
>>versions of these problems appear into the future?
> 
> 
> Disabeling ecn is a workaround for b0rken firewalls and may result in
> using more bandwidth than nescensary. If disabeling ecn helps, dump the
> firewall and get something that supports basic internet standards (or
> ask the owner to do this).
> 
Like many other parameters, ecn can improve performance but may result 
in a non-functional network. Based on that I still think it's better for 
the default to be "works" and use of ecn or other tuning parameters such 
as reducing timeouts should be "tuning" instead.

Adding a few printk's seems to show that ecn is not so common that it 
needs to be on by default. I suspect that the main use of ecn code is in 
fighting with those broken routers and firewalls rather than improving 
performance.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
