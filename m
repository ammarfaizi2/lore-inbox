Return-Path: <linux-kernel-owner+w=401wt.eu-S932901AbXAAEqe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932901AbXAAEqe (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 23:46:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932904AbXAAEqe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 23:46:34 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:53751 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932901AbXAAEqd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 23:46:33 -0500
Message-ID: <45988E72.9020209@oracle.com>
Date: Sun, 31 Dec 2006 20:30:42 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
CC: Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       "Robert P. J. Day" <rpjday@mindspring.com>, trivial@kernel.org
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line
 macros.
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain> <20061231194501.GE3730@rhun.ibm.com> <Pine.LNX.4.64.0612311447030.18368@localhost.localdomain> <66cc662565c489fa9e604073ced64889@kernel.crashing.org> <45987EB0.1020505@oracle.com> <8952abefff5a73bf24a0c80936fe7091@kernel.crashing.org>
In-Reply-To: <8952abefff5a73bf24a0c80936fe7091@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Segher Boessenkool wrote:
>>>>   #define setcc(cc) ({ \
>>>>     partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
>>>>     partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); })
>>> This _does_ return a value though, bad example.
>>
>> Where does it return a value?
> 
> partial_status |=

as I expected (or suspected).
I also suspect that it wasn't intended, but this is old code
and I wasn't around Linux when it was written, so I don't know
about it for sure.

>> I don't see any uses of it
> 
> Ah, that's a separate thing -- it returns a value, it's just
> never used.

Ack.

>> And with a small change to put it inside a do-while block
>> instead of ({ ... }), it at least builds cleanly.
> 
> Well please replace it then, statement expressions should be
> avoided where possible (to start with, they don't have well-
> defined semantics).

We should probably avoid gcc extensions when possible.

I'll send a separate email for the patch.

-- 
~Randy
