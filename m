Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261218AbTCYV1w>; Tue, 25 Mar 2003 16:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261357AbTCYV1w>; Tue, 25 Mar 2003 16:27:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:15887 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261218AbTCYV1v>; Tue, 25 Mar 2003 16:27:51 -0500
Message-ID: <3E80CC55.6010007@zytor.com>
Date: Tue, 25 Mar 2003 13:38:29 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Martin Hicks <mort@bork.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [patch] Generic way to control display of debug printk's
References: <20030321223717.GA1241@bork.org> <b5ggva$2lu$1@cesium.transmeta.com> <20030325192843.GB11198@bork.org>
In-Reply-To: <20030325192843.GB11198@bork.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Hicks wrote:
> 
> Okay, perhaps I didn't clearly identify the problem last time.  The
> problem is the number of messages that go into the log_buf.  On
> large systems we can certainly just crank up the size of log_buf, but I
> don't see this as a terribly elegant solution.
> 
> I think there should be some facility, mirroring the way we can set a
> threshold for console messages, to decide if a message is logged at all.
> For example, setting console_loglevel and log_loglevel (the new
> threshold) to 7 results in no KERN_DEBUG messages begin printed to the
> console or the log.
> 
> I'm testing a patch now, but are there any comments on the basic idea?
> Is it preferrable to just crank up the size of log_buf?
> 

This is probably a good idea.  It might also be worthwhile to implement
per-subsystem filtering similar to what syslog has; the network
subsystem is particular is notoriously noisy when it comes to telling me
that someone else sent bad packets.  If you're a public Internet server,
that happens *all the time*...

	-hpa


