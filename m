Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268622AbTCCV5m>; Mon, 3 Mar 2003 16:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268625AbTCCV5m>; Mon, 3 Mar 2003 16:57:42 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:35275 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP
	id <S268622AbTCCV5m>; Mon, 3 Mar 2003 16:57:42 -0500
Date: Tue, 04 Mar 2003 11:06:50 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Re: [ACPI] Re: S4bios support for 2.5.63
In-reply-to: <20030303143006.GA1289@k3.hellgate.ch>
To: Roger Luethi <rl@hellgate.ch>
Cc: Troels Haugboelle <troels_h@astro.ku.dk>, Pavel Machek <pavel@suse.cz>,
       bert hubert <ahu@ds9a.nl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1046729210.1850.8.camel@laptop-linux.cunninghams>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.1
Content-type: text/plain
Content-transfer-encoding: 7bit
References: <20030302133138.GA27031@outpost.ds9a.nl>
 <1046630641.3610.13.camel@laptop-linux.cunninghams>
 <20030302202118.GA2201@outpost.ds9a.nl>
 <20030303003940.GA13036@k3.hellgate.ch>
 <1046657290.8668.33.camel@laptop-linux.cunninghams>
 <20030303113153.GA18563@outpost.ds9a.nl>
 <20030303122325.GA20929@atrey.karlin.mff.cuni.cz>
 <20030303123551.GA19859@outpost.ds9a.nl>
 <20030303124133.GH20929@atrey.karlin.mff.cuni.cz>
 <1046700474.3782.197.camel@localhost> <20030303143006.GA1289@k3.hellgate.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-04 at 03:30, Roger Luethi wrote:
> Not sure I follow all of your story but I can confirm that hdparm -u1
> successfully gets me to the kernel panic due to highmem support still
> lacking -- i.e. way beyond the BUG_ON() I've been hitting. So it looks
> like you found a good work-around.

You were hitting the BUG_ON before swsusp was even trying to write the
image?!! That is interesting! Since count_and_copy is first called post
driver suspend in the current version, perhaps they are somehow related.
(This is before swsusp tries to write any of the image to disk).

Regards,

Nigel

