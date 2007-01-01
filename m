Return-Path: <linux-kernel-owner+w=401wt.eu-S1755225AbXAAPl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755225AbXAAPl3 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 10:41:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755228AbXAAPl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 10:41:28 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:32919 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755225AbXAAPl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 10:41:28 -0500
Date: Mon, 1 Jan 2007 16:37:20 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Randy Dunlap <randy.dunlap@oracle.com>
cc: Segher Boessenkool <segher@kernel.crashing.org>,
       "Robert P. J. Day" <rpjday@mindspring.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       trivial@kernel.org
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line
 macros.
In-Reply-To: <45987EB0.1020505@oracle.com>
Message-ID: <Pine.LNX.4.61.0701011635420.24520@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain>
 <20061231194501.GE3730@rhun.ibm.com> <Pine.LNX.4.64.0612311447030.18368@localhost.localdomain>
 <66cc662565c489fa9e604073ced64889@kernel.crashing.org> <45987EB0.1020505@oracle.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 31 2006 19:23, Randy Dunlap wrote:
>> > 
>> > #define setcc(cc) ({ \
>> > partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
>> > partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); })
>> 
>> This _does_ return a value though, bad example.
>
> Where does it return a value?  I don't see any uses of it
> in arch/i386/math-emu/* that use it as returning a value.
>
> And with a small change to put it inside a do-while block
> instead of ({ ... }), it at least builds cleanly.
> I expected some complaints.

If people want to return something from a ({ }) construct, they should do it
explicitly, e.g.

#define setcc(cc) ({ \
	partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
	partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); \
	partial_status; \
})


	-`J'
-- 
