Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273663AbRIQTvN>; Mon, 17 Sep 2001 15:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273664AbRIQTvD>; Mon, 17 Sep 2001 15:51:03 -0400
Received: from dynamic-135.remotepoint.com ([204.221.114.135]:19718 "EHLO
	AeroSpace.davidapt.local") by vger.kernel.org with ESMTP
	id <S273663AbRIQTux>; Mon, 17 Sep 2001 15:50:53 -0400
Date: Mon, 17 Sep 2001 14:51:30 -0500
From: David Fries <dfries@mail.win.org>
To: John Weber <john@worldwideweber.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: how to get cpu_khz?
Message-ID: <20010917145130.C4041@aerospace.fries.net>
In-Reply-To: <fa.ginsptv.1gg45b5@ifi.uio.no> <3BA64ADE.999E1402@worldwideweber.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BA64ADE.999E1402@worldwideweber.org>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2001 at 03:11:26PM -0400, John Weber wrote:
> David Fries wrote:
> > 
> > I'm using the TSC of the Pentium processors to get some precise timing
> > delays for writing to a eeprom (bit banging bus operations), and it
> > works just fine, but the cpu_khz variable isn't exported to a kernel
> > module, so I hardcoded in my module.  It works fine for that one
> > system, but obviously I don't want to hard code it for the general
> > case.  I guess I could write my own routine to figure out what the
> > cpu_khz is, but it is already done, so how do I get access to it?
> 
> I don't know of any official way of doing this, but here's some 
> code (written by aa) that accomplishes this.

For a user space program you could just read /proc/cpuinfo, I'm
actually writing a kernel driver, maybe I wasn't clear enough.  I'm
just frustrated because the variable I'm after, cpu_khz is already
calculated at boot time (that's where /proc/cpuinfo gets its data) and
that variable doesn't appear to be exported to the rest of the kernel,
either that or I'm just missing something, which I would rather be the
case at this point.

-- 
		+---------------------------------+
		|      David Fries                |
		|      dfries@mail.win.org        |
		+---------------------------------+
