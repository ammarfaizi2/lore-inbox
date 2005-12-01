Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932285AbVLAPki@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932285AbVLAPki (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 10:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbVLAPki
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 10:40:38 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:12761 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932286AbVLAPkh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 10:40:37 -0500
Date: Thu, 1 Dec 2005 16:40:24 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Kyle Moffett <mrmacman_g4@mac.com>
cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu, george@mvista.com, johnstul@us.ibm.com
Subject: Re: [patch 00/43] ktimer reworked
In-Reply-To: <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
Message-ID: <Pine.LNX.4.61.0512011352590.1609@scrub.home>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0512010118200.1609@scrub.home> <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 30 Nov 2005, Kyle Moffett wrote:

> If I recall correctly, this whole naming mess has been discussed to death
> before, with the result that almost everybody but Roman thought the names were
> perfectly clear such that a timer is _expected_ to expire and a timeout is
> not, therefore timers should be optimized for add=>run=>expire and timeouts
> optimized for add=>run=>remove.

The human language is a bit more complicated than this (at least English 
and related languages). Depending on the context a word can have different 
meanings, e.g. if you ask an athlete what "timeout" means, you'll get a 
different answer than you would get from an engineer. Even if we limit it 
to the technical field one can define "timeout" very generally as "a 
period of time after which an event is generated". Does this imply this 
timeout is usually aborted? For some people it obviously does, but I 
highly doubt this is generally true. Without any context "timeout" can 
mean many similiar, but still different things. If you don't provide any 
context, it will trigger different associations and people will add their 
own context of how they use "timeout". You will of course find a large 
overlap, but the less context you provide, the more likely are 
misunderstandings.

A good name provides enough context to minimize misunderstandings, the 
name is important for how people will perceive and use something. Here we 
get to a larger problem, which goes beyond simple naming issues. Thomas 
and Ingo seem to want to completely redefine how time is managed in the 
kernel. The consequences for this would be very farreaching and should be 
discussed independently. Discussing this under the topic of high 
resolution timer would provide the entirely wrong context and lead to 
misunderstandings.

Whatever it is Thomas and Ingo are trying to do with the current kernel 
timer, they have to explain it in the proper context. I'm not going to 
second-guess their intentions and sneaking these changes in as part of the 
high resolution timer is unacceptable.

bye, Roman
