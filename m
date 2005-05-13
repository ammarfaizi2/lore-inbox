Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVEMS43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVEMS43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 14:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262487AbVEMSys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 14:54:48 -0400
Received: from smtpout.mac.com ([17.250.248.88]:25325 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262489AbVEMSwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 14:52:46 -0400
In-Reply-To: <20050513182650.GJ23488@csclub.uwaterloo.ca>
References: <1116001207.5239.38.camel@localhost.localdomain> <20050513171758.GB23621@csclub.uwaterloo.ca> <1116006828.5239.72.camel@localhost.localdomain> <20050513180915.GH23488@csclub.uwaterloo.ca> <1116008483.5239.79.camel@localhost.localdomain> <20050513182650.GJ23488@csclub.uwaterloo.ca>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c34f1e127a3bd4cbf62a0b81350ab6e8@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org, "Michael H. Warfield" <mhw@wittsend.com>
From: Mark Rustad <mrustad@mac.com>
Subject: Re: Flash device types
Date: Fri, 13 May 2005 13:52:37 -0500
To: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
X-Mailer: Apple Mail (2.622)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 13, 2005, at 1:26 PM, Lennart Sorensen wrote:

> Not really.  I believe sandisk has wear leveling on the 201 series CF
> cards and on their new generation CF/SD for sure they have it (and
> unfortunately for us they discontinued industrial temperature in the 
> new
> line so we have had to look elsewhere for CF cards).
>
> Unfortunately a lot of what is sold to consumers at retail is cheap
> crap. :)

It does seem to be a problem finding out how things really work in 
these devices. There seem to be the following types (from worst to 
best):

1. No wear leveling. Bad blocks are mapped out at manuf. time and that 
is it.
2. Bad blocks are detected and remapped dynamically. This is sometimes 
called wear-leveling, but the device life is a function of how many 
spares there originally were.
3. "Real" wear leveling. This can move data to fully use the life of 
all sectors.
4. "Real" wear leveling with lots of optimization and write cache - 
these are large devices usually with the ability to have battery power 
to ensure write cache can be flushed out.

#4 is easy to determine because of the size and complexity of the 
things. The others are much harder to distinguish and it really is 
important to know what you are dealing with. If you can't find out how 
it works, I would assume #1 or #2 which are both pretty poor.

It really would be nice to easily find out what category of device 
these things really are.

-- 
Mark Rustad, MRustad@mac.com

