Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbTDLAKP (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 20:10:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262219AbTDLAKP (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 20:10:15 -0400
Received: from uucp.cistron.nl ([62.216.30.38]:43019 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S261867AbTDLAKN (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 20:10:13 -0400
From: miquels@cistron-office.nl (Miquel van Smoorenburg)
Subject: Re: [ANNOUNCE] udev 0.1 release
Date: Sat, 12 Apr 2003 00:21:53 +0000 (UTC)
Organization: Cistron Group
Message-ID: <b77m71$7bs$1@news.cistron.nl>
References: <20030411172011.GA1821@kroah.com> <20030411190717.GH1821@kroah.com> <b77jmr$31d$1@news.cistron.nl> <20030412000829.GL4539@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1050106913 7548 62.216.29.200 (12 Apr 2003 00:21:53 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20030412000829.GL4539@kroah.com>,
Greg KH  <greg@kroah.com> wrote:
>On Fri, Apr 11, 2003 at 11:39:07PM +0000, Miquel van Smoorenburg wrote:
>> Why not serialize /sbin/hotplug at the kernel level. Queue hotplug
>> events and only allow one /sbin/hotplug to run at the same time.
>
>We don't want the kernel to stop based on a user program.

It would not stop if you queued the events.

What is the difference between queueing events to be read from
a pipe or socket or queueing them for a kernel thread that empties
the queue by executing /sbin/hotplug for each entry in the queue.

The pipe/socket solution is probably better anyway, I was just
wondering why /sbin/hotplug wasn't serialized from the start.
 
Mike.

