Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269179AbUING4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269179AbUING4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 02:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269176AbUING4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 02:56:54 -0400
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:50655 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id S269172AbUING4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 02:56:47 -0400
From: "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
Organization: Universitaet Regensburg, Klinikum
To: Christoph Lameter <clameter@sgi.com>
Date: Tue, 14 Sep 2004 08:53:45 +0200
MIME-Version: 1.0
Subject: Re: [RFC][PATCH] new timeofday core subsystem (v.A0)
CC: george anzinger <george@mvista.com>,
       Albert Cahalan <albert@users.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>, tim@physik3.uni-rostock.de,
       Ulrich.Windl@rz.uni-regensburg.de, Len Brown <len.brown@intel.com>,
       linux@dominikbrodowski.de, David Mosberger <davidm@hpl.hp.com>,
       Andi Kleen <ak@suse.de>, paulus@samba.org, schwidefsky@de.ibm.com,
       jimix@us.ibm.com, keith maanthey <kmannth@us.ibm.com>,
       greg kh <greg@kroah.com>, Patricia Gaughen <gone@us.ibm.com>,
       Chris McDermott <lcm@us.ibm.com>
Message-ID: <4146B19D.4429.1A51DA@rkdvmks1.ngate.uni-regensburg.de>
In-reply-to: <Pine.LNX.4.58.0409131534320.616@schroedinger.engr.sgi.com>
References: <1095114307.29408.285.camel@cog.beaverton.ibm.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Content-Conformance: HerringScan-0.25/Sophos-3.84+2.20+2.07.066+02 August 2004+93389@20040914.064826Z
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Sep 2004 at 15:45, Christoph Lameter wrote:

> > o My only other nit is that you use a different name then xtime. If
> > you're changing the type, you might as well use a meaningful name.
> 
> xtime is the traditional name. Maybe renaming it to intentionally break
> old code would be good but I thought it would be good to understand
> the approach.
> 

I think direct access to xtime should vanish. Provide an inlinable function to get 
the current time coarsely and quickly (that's what reading xtime is).

Ulrich


