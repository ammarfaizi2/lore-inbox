Return-Path: <linux-kernel-owner+w=401wt.eu-S1753633AbXAATPn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753633AbXAATPn (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:15:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932669AbXAATPn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:15:43 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:46364 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753633AbXAATPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:15:42 -0500
Date: Mon, 1 Jan 2007 20:11:02 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
cc: "Robert P. J. Day" <rpjday@mindspring.com>, trivial@kernel.org,
       Randy Dunlap <randy.dunlap@oracle.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line
 macros.
In-Reply-To: <fb88b3708d2228b345fe68a5a207d069@kernel.crashing.org>
Message-ID: <Pine.LNX.4.61.0701012010180.24520@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain>
 <20061231194501.GE3730@rhun.ibm.com> <Pine.LNX.4.64.0612311447030.18368@localhost.localdomain>
 <66cc662565c489fa9e604073ced64889@kernel.crashing.org> <45987EB0.1020505@oracle.com>
 <Pine.LNX.4.61.0701011635420.24520@yvahk01.tjqt.qr>
 <fb88b3708d2228b345fe68a5a207d069@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Jan 1 2007 18:51, Segher Boessenkool wrote:
>> If people want to return something from a ({ }) construct, they should do
>> it
>> explicitly, e.g.
>> 
>> #define setcc(cc) ({ \
>> partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
>> partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); \
>> partial_status; \
>> })
>
> No, they generally should use an inline function instead.

Perhaps. But that won't work with defines where typeof is involved.


	-`J'
-- 
