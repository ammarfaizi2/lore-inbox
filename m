Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289032AbSAFUlT>; Sun, 6 Jan 2002 15:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289031AbSAFUlJ>; Sun, 6 Jan 2002 15:41:09 -0500
Received: from lawcv2.lcisp.com ([12.44.138.11]:32019 "EHLO lcisp.com")
	by vger.kernel.org with ESMTP id <S289030AbSAFUlA>;
	Sun, 6 Jan 2002 15:41:00 -0500
From: "Kevin Krieser" <kkrieser_list@footballmail.com>
To: "Marcin Tustin" <mt500@ecs.soton.ac.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: Whizzy New Feature: Paged segmented memory
Date: Sun, 6 Jan 2002 14:41:07 -0600
Message-ID: <NDBBLFLJADKDMBPPNBALKEDCHAAA.kkrieser_list@footballmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <Pine.LNX.4.33.0201061408540.7398-100000@localhost.localdomain>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Even if you decided to come up with a whole new OS designed around it, along
with tools, you couldn't solve all your problems with this method.

Mainly, it is because of the limited number of segments you can have in a
process.  And unless Intel extended the number of segments when they went
from the 286 to the 386, you would be limited to 8192 (16384) segments in a
process, way too few to make usable programs in this day and age.  And once
you start combining data within segments, you have opened the door to buffer
overruns again.

>>
	Any comments on how useful it would be to have paged, segmented,
memory support for Pentium? I was thinking that by having separate
segments for text, stack, and heap, buffer overrun exploits would be
eliminated (I'm aware that this would require GCC patching as well).
	Obviously, I'm thinking that I (and any similar fools I could rope
in) would try this (Probably delivering for a kernel at least a year out
of date by the time we had a patch).
<<

