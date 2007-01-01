Return-Path: <linux-kernel-owner+w=401wt.eu-S933242AbXAADh6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933242AbXAADh6 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 22:37:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933243AbXAADh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 22:37:58 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:49890 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933242AbXAADh6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 22:37:58 -0500
Message-ID: <45987EB0.1020505@oracle.com>
Date: Sun, 31 Dec 2006 19:23:28 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
CC: "Robert P. J. Day" <rpjday@mindspring.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line
 macros.
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain> <20061231194501.GE3730@rhun.ibm.com> <Pine.LNX.4.64.0612311447030.18368@localhost.localdomain> <66cc662565c489fa9e604073ced64889@kernel.crashing.org>
In-Reply-To: <66cc662565c489fa9e604073ced64889@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool wrote:
>>> In this case, the second form
>>> should be used when the macro needs to return a value (and you can't
>>> use an inline function for whatever reason), whereas the first form
>>> should be used at all other times.
>>
>> that's a fair point, although it's certainly not the coding style
>> that's in play now.  for example,
>>
>>   #define setcc(cc) ({ \
>>     partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
>>     partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); })
> 
> This _does_ return a value though, bad example.

Where does it return a value?  I don't see any uses of it
in arch/i386/math-emu/* that use it as returning a value.

And with a small change to put it inside a do-while block
instead of ({ ... }), it at least builds cleanly.
I expected some complaints.

-- 
~Randy
