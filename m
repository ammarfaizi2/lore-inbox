Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261384AbVAOSG3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbVAOSG3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jan 2005 13:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261926AbVAOSG2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jan 2005 13:06:28 -0500
Received: from fw.osdl.org ([65.172.181.6]:39876 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261384AbVAOSG1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jan 2005 13:06:27 -0500
Date: Sat, 15 Jan 2005 10:05:37 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: davidm@hpl.hp.com
cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: sparse warning, or why does jifies_to_msecs() return an int?
In-Reply-To: <16872.45268.823377.293250@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.58.0501150948120.2310@ppc970.osdl.org>
References: <200501150221.j0F2L2aD021862@napali.hpl.hp.com>
 <Pine.LNX.4.58.0501142020130.2310@ppc970.osdl.org> <16872.45268.823377.293250@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 14 Jan 2005, David Mosberger wrote:
> 
> How about something along the lines of the attached?  The test in
> msecs_to_jiffies is non-sensical for HZ>=1000

Hmm.. I don't think your patch is wrong per se, but I do think it's a bit 
too subtle. I'd almost rather make "jiffies_to_msecs()" just test for 
overflow instead, and that should also fix it.

		Linus
