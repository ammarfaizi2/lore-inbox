Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267437AbUHTNql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267437AbUHTNql (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 09:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267473AbUHTNql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 09:46:41 -0400
Received: from mail.enyo.de ([212.9.189.167]:41733 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S267437AbUHTNqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 09:46:36 -0400
To: Alexander Nyberg <alexn@telia.com>
Cc: Miles Lane <miles.lane@comcast.net>, linux-kernel@vger.kernel.org
Subject: Re: DTrace-like analysis possible with future Linux kernels?
References: <200408191822.48297.miles.lane@comcast.net>
	<87hdqyogp4.fsf@killer.ninja.frodoid.org>
	<87k6vu3bet.fsf@deneb.enyo.de> <1093008895.7824.11.camel@boxen>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Fri, 20 Aug 2004 15:46:33 +0200
In-Reply-To: <1093008895.7824.11.camel@boxen> (Alexander Nyberg's message of
	"Fri, 20 Aug 2004 15:34:55 +0200")
Message-ID: <87acwp2a86.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alexander Nyberg:

>> Most other system resources can be tracked quite easily: disk space,
>> CPU time, committed address space, even network I/O (with tcpdump and
>> netstat -p).  But there's no such thing for disk I/O.
>
> Why can't this be done be looking at the major faults a process causes?

Because only paging results in major faults, normal I/O with
read()/write() (or the p*() variants) does not.

> One could quite easily hack up a tool to monitor I/O per process or
> does it need to be very more precise?

It would be nice to obtain file names, too.
