Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264310AbUDSItz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 04:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264309AbUDSItz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 04:49:55 -0400
Received: from web90008.mail.scd.yahoo.com ([66.218.94.66]:18580 "HELO
	web90008.mail.scd.yahoo.com") by vger.kernel.org with SMTP
	id S264304AbUDSIto (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 04:49:44 -0400
Message-ID: <20040419084943.61269.qmail@web90008.mail.scd.yahoo.com>
Date: Mon, 19 Apr 2004 01:49:43 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: periodic flushing of "cached" data
To: linux-newbie@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for your response.  I have given this a try
(and other options to get pdflush to wake up and flush
more data) with a file system that is currently in use
with no difference.

Interestingly enough, I created an application that
just allocates memory and ran it to eat up 500M.  I
the app and it forced the cached data to disk and
freed up 500M which then was filled up again by NFS
data.

I would like to get similiar behavior as that what I
see and know of NetWork Appliance Data OnTAP.  Within
their configuration they have several note worthy
principles:

1: Cached data can not be older than 20 secs without
being committed to disk
2: if there is significant data filling the caches and
heavy network traffic, it will throttle the network
interface and begin moving data to disks.  It does
this very well and in a very balanced fashion.

Currently, an older generation NetApp Filer F760 is
able to out run my linux file server by 30-50% (the
F880 is a dual 800MHz PIII, my file server is a quad
Xeon 2.0GHz, both machines are FC).

Is there any way to get the Linux kernel to do the
same as OnTAP and be on par or better than the F880.

Thank you very much for your time.

Phy Prabab
--- Andrew Morton <akpm@osdl.org> wrote:
> Phy Prabab <phyprabab@yahoo.com> wrote:
> >
> > Sirs,
> > 
> > I am interested in understanding how tot tune the
> 2.6
> > kernel such that I can get the WM to write out
> data
> > that is held within the "cache".
> > 
> > My situtation is that I have a NFS file server
> that
> > gets data in bursts.  The first couple of burst
> move
> > quickly, but once the system memory becomes
> filled,
> > mostly held in "cache", then my NFS performance
> drops.
> >  The issue here is how to get the VM to write out
> the
> > data held within the cache when times are slow
> (which
> > amounts to 90% of the time)?  I have played a
> little
> > bit with the /proc/sys/vm/dirty_ratio, etc with
> out
> > much help.
> 
> Setting dirty_background_ratio lower might smooth
> things out.






	
		
__________________________________
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash
