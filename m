Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbTHOK6R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 06:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263062AbTHOK6Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 06:58:16 -0400
Received: from pix-525-pool.redhat.com ([66.187.233.200]:62901 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S262254AbTHOK6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 06:58:14 -0400
Date: Fri, 15 Aug 2003 11:57:33 +0100
From: Dave Jones <davej@redhat.com>
To: Jonathan Morton <chromi@chromatix.demon.co.uk>
Cc: Robert Toole <tooler@tooleweb.homelinux.com>, linux-kernel@vger.kernel.org
Subject: Re: agpgart failure on KT400
Message-ID: <20030815105733.GC22433@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jonathan Morton <chromi@chromatix.demon.co.uk>,
	Robert Toole <tooler@tooleweb.homelinux.com>,
	linux-kernel@vger.kernel.org
References: <3F3C2DA0.1030504@tooleweb.homelinux.com> <BD8AF95A-CEC1-11D7-A88B-003065664B7C@chromatix.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BD8AF95A-CEC1-11D7-A88B-003065664B7C@chromatix.demon.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 02:42:33AM +0100, Jonathan Morton wrote:

 > Surely it's not too big a job to get basic, generic AGP3 support into 
 > 2.4, even if it's not optimised?  If it's non-trivial to make all AGP3 
 > features work in 2.4, then it's reasonable to require 2.6 for "better 
 > performance".

It's more a maintenance burden. The 2.4 code is *shit*.
If I was to be doing any amount of work on that code, I'd want the
cleanups that came with the work I did in 2.6 too.
Bending all the infrastructure in 2.6 to fit 2.4, testing, debugging etc
is at least a few evenings work.  I'm just one guy.  Unless Red Hat
decide that AGP3 is something they really really must have for some
future 2.4 release, it isn't going to happen by me. Period.
I'm just up to my eyes in other work.

 > To be honest, I'd at least expect a fallback to AGP2 for hardware that 
 > can support it, such as KT400.  The Windows drivers for my ATI card can 
 > tell the hardware to drop to "AGP 4x" (which I believe implies AGP2 - I 
 > could be wrong), and the card *did* work correctly with the KT266A 
 > chipset I was using before.

Nope. You can do X4 in AGP3 mode, which is different from X4 in AGP2.

 > However, I did encounter a compilation problem with one of the USB 
 > device drivers - not a major problem at present since that particular 
 > device is attached to a different machine - but it does show that 2.6 
 > isn't ready for primetime yet.  The major distros aren't going to make 
 > that switch for a while.

Several distros (Red Hat included) have 2.6 based kernel packages for
people to test with, which takes the pain off of compilation issues
for most users.

		Dave

-- 
 Dave Jones     http://www.codemonkey.org.uk
