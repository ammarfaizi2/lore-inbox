Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265795AbUAKINO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 03:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265799AbUAKINN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 03:13:13 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:5815 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S265795AbUAKIMw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 03:12:52 -0500
Date: Sun, 11 Jan 2004 09:12:47 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dax Kelson <dax@gurulabs.com>
Cc: Pavel Machek <pavel@suse.cz>, kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: Do not use synaptics extensions by default
Message-ID: <20040111081247.GB25497@ucw.cz>
References: <20040110175930.GA1749@elf.ucw.cz> <20040110193039.GA22654@ucw.cz> <20040110194420.GA1212@elf.ucw.cz> <20040110195531.GD22654@ucw.cz> <1073778167.7644.4.camel@mentor.gurulabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073778167.7644.4.camel@mentor.gurulabs.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 10, 2004 at 04:42:48PM -0700, Dax Kelson wrote:

> On Sat, 2004-01-10 at 12:55, Vojtech Pavlik wrote:
> > Or, the very nice thing to do would be to port the XFree86 driver to
> > GPM, so that GPM can understand the event protocol as well.
> 
> Already done...

Cool! I forgot. I thought only the regular mouse event protocol was
added.

> # rpm -q gpm
> gpm-1.20.1-dt8
> 
> # ps -e o pid,user,cmd | grep gpm
>  2068 root     gpm -m /dev/input/event0 -t evdev -o type=synaptics -M -m /dev/input/mice -t imps2
> 
> I believe the issue is that /dev/input/event0 can't be opened by
> multiple things (gpm and X) in 2.4 as can be done in 2.6.

It can be opened by any number of programs on both 2.4 and 2.6. 2.4
doesn't have the synaptics (or any other ps/2) mouse driver and thus
it's only used for USB mice.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
