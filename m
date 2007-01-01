Return-Path: <linux-kernel-owner+w=401wt.eu-S932896AbXAAEbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932896AbXAAEbl (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 23:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932898AbXAAEbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 23:31:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:37588 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932896AbXAAEbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 23:31:41 -0500
In-Reply-To: <45987EB0.1020505@oracle.com>
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain> <20061231194501.GE3730@rhun.ibm.com> <Pine.LNX.4.64.0612311447030.18368@localhost.localdomain> <66cc662565c489fa9e604073ced64889@kernel.crashing.org> <45987EB0.1020505@oracle.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8952abefff5a73bf24a0c80936fe7091@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       "Robert P. J. Day" <rpjday@mindspring.com>, trivial@kernel.org
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line macros.
Date: Mon, 1 Jan 2007 05:31:32 +0100
To: Randy Dunlap <randy.dunlap@oracle.com>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>   #define setcc(cc) ({ \
>>>     partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
>>>     partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); })
>> This _does_ return a value though, bad example.
>
> Where does it return a value?

partial_status |=

> I don't see any uses of it

Ah, that's a separate thing -- it returns a value, it's just
never used.

> And with a small change to put it inside a do-while block
> instead of ({ ... }), it at least builds cleanly.

Well please replace it then, statement expressions should be
avoided where possible (to start with, they don't have well-
defined semantics).


Segher

