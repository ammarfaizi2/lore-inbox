Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUF3HDr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUF3HDr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 03:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266172AbUF3HDr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 03:03:47 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:36764 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266155AbUF3HDq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 03:03:46 -0400
Message-ID: <40E265CF.9040307@yahoo.com.au>
Date: Wed, 30 Jun 2004 17:03:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: "Christopher S. Aker" <caker@theshore.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4 and 2.6.7 page allocation failure / e1000 related ?
References: <003c01c45e6b$a2323ed0$0201a8c0@hawk>
In-Reply-To: <003c01c45e6b$a2323ed0$0201a8c0@hawk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christopher S. Aker wrote:
> Hello,
> 
> I've had this appear in dmesg a few times on a number of different systems, all
> identical hardware: SuperMicro 6013P-i dual Xeon, with 4GB of RAM, built-in e1000
> NICs connected via 100Mbit switch.
> 
> It doesn't appear to cause any ill effects.  I haven't provided all the variations
> of the messages, but the consistent thing between them are the e1000_* calls.
> This isn't an OOM situation, the machines are only a handful of MB into swap (if
> that).
> 

It shouldn't cause any problems, although an order 0 failure
shouldn't be happening often.

It is possible we want to increase /proc/sys/vm/min_free_kbytes
a bit, or increase the amount of extra memory a __GFP_HIGH
allocation can get access to.

You could try the increasing former and see if that helps.
