Return-Path: <linux-kernel-owner+w=401wt.eu-S1161329AbWLPSPg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161329AbWLPSPg (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 13:15:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161330AbWLPSPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 13:15:36 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:52889 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161329AbWLPSPf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 13:15:35 -0500
Date: Sat, 16 Dec 2006 19:14:47 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Pavel Machek <pavel@ucw.cz>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: lots of code could be simplified by using ARRAY_SIZE()
In-Reply-To: <Pine.LNX.4.64.0612160802250.3660@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0612161912390.30896@yvahk01.tjqt.qr>
References: <Pine.LNX.4.64.0612131450270.5979@localhost.localdomain>
 <20061216084007.GC4049@ucw.cz> <Pine.LNX.4.64.0612160802250.3660@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 16 2006 08:09, Robert P. J. Day wrote:
>On Sat, 16 Dec 2006, Pavel Machek wrote:
>> > but we already have, from "include/linux/kernel.h":
>> >
>> >   #define ARRAY_SIZE(x) (sizeof(x) / sizeof((x)[0]))
>>
>> Hmmm. quite misleading name :-(. ARRAY_LEN would be better.
>
>i suspect it's *way* too late to make that kind of change, given that
>"ARRAY_SIZE" is firmly ensconced in countless places in the source
>tree and that would be a major, disruptive change.
>
>even *i* wouldn't try to promote that idea.  :-)

You know, you could always make it compat for a while, but that requires
approval from Linus I suppose /* heh, heh */

I don't even know if this will compile everywhere,
but I hope you can figure out the idea...

#define ARRAY_SIZE(x) (print_warning(), sizeof(x) / sizeof(*x))
#define ARRAY_LEN(x)  (sizeof(x) / sizeof(*x))
extern ...
void print_warning(void) {
    printk("Don't use ARRAY_SIZE anymore, it will go away\n");
}


	-`J'
-- 
