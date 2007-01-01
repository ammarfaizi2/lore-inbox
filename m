Return-Path: <linux-kernel-owner+w=401wt.eu-S1755244AbXAARvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755244AbXAARvX (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 12:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755245AbXAARvX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 12:51:23 -0500
Received: from gate.crashing.org ([63.228.1.57]:59177 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755244AbXAARvW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 12:51:22 -0500
In-Reply-To: <Pine.LNX.4.61.0701011635420.24520@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612311430370.18269@localhost.localdomain> <20061231194501.GE3730@rhun.ibm.com> <Pine.LNX.4.64.0612311447030.18368@localhost.localdomain> <66cc662565c489fa9e604073ced64889@kernel.crashing.org> <45987EB0.1020505@oracle.com> <Pine.LNX.4.61.0701011635420.24520@yvahk01.tjqt.qr>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fb88b3708d2228b345fe68a5a207d069@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
Cc: "Robert P. J. Day" <rpjday@mindspring.com>, trivial@kernel.org,
       Randy Dunlap <randy.dunlap@oracle.com>,
       Muli Ben-Yehuda <muli@il.ibm.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Documentation: Explain a second alternative for multi-line macros.
Date: Mon, 1 Jan 2007 18:51:05 +0100
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
X-Mailer: Apple Mail (2.623)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> If people want to return something from a ({ }) construct, they should 
> do it
> explicitly, e.g.
>
> #define setcc(cc) ({ \
> 	partial_status &= ~(SW_C0|SW_C1|SW_C2|SW_C3); \
> 	partial_status |= (cc) & (SW_C0|SW_C1|SW_C2|SW_C3); \
> 	partial_status; \
> })

No, they generally should use an inline function instead.


Segher

