Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267149AbTBDISp>; Tue, 4 Feb 2003 03:18:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267153AbTBDISp>; Tue, 4 Feb 2003 03:18:45 -0500
Received: from pc2-alde1-3-cust225.glfd.cable.ntl.com ([213.107.78.225]:9297
	"EHLO mayday.local") by vger.kernel.org with ESMTP
	id <S267149AbTBDISo>; Tue, 4 Feb 2003 03:18:44 -0500
Date: Tue, 4 Feb 2003 08:27:38 +0000 (GMT)
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: Matti Aarnio <matti.aarnio@zmailer.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH *] use 64 bit jiffies
In-Reply-To: <200302040643.h146gps10473@Port.imtp.ilyichevsk.odessa.ua>
X-URL: <http://www.cix.co.uk/~mayday>
X-Dev86-Version: 0.16.10
Reply-By: 01 jan 2001 00:00:00
X-Message-Flag: Linux: The choice of a GNU generation.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
From: Robert de Bath <robert$@mayday.cix.co.uk>
Message-ID: <6789aaded8e91844@mayday.cix.co.uk>
X-Mailer: Pine for Linux
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 4 Feb 2003, Denis Vlasenko wrote:

> 		Jiffy Wrap Bugs
>
> There were reports of machines hanging on jiffy wrap.
> This is typically a result of incorrect jiffy use in some driver.
> Ask Tim - he is hunting those problems regularly, but he is outnumbered
> by buggy driver authors. :(
>
> There is a better solution to ensure correct jiffy wrap handling in
> *ALL* kernel code: make jiffy wrap in first five minutes of uptime.
> Tim has a patch for such config option. This is almost right.
> This MUST NOT be a config option, it MUST be mandatory in every
> kernel. Driver writers would be bitten by their own bugs and will
> fix it themself. Tim, what do you think?

How about an option, either the jiffy timer wraps at 5 minutes or
process 1 gets sent a SIGINT after 24 hours ? That way a driver
with an MIA author can still be used even if it's buggy, just not
for very long.

Okay ... perhaps it should be just an option of jiffy wrap at 5 mins
or 24 hours, but I still think reboot is better :-) :-P

-- 
Rob.                          (Robert de Bath <robert$ @ debath.co.uk>)
                                       <http://www.cix.co.uk/~mayday>
Google Homepage:   http://www.google.com/search?btnI&q=Robert+de+Bath

