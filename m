Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270772AbTHOUXL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 16:23:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270801AbTHOUXL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 16:23:11 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:23559 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S270772AbTHOUXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 16:23:07 -0400
Date: Fri, 15 Aug 2003 22:23:04 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Pete Nishimoto <Peter.Nishimoto@Sun.COM>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, Peten@ekb.East.Sun.COM
Subject: Re: possible auto-partition bug? (linux-2.4.20-8)
Message-ID: <20030815222304.A3272@pclin040.win.tue.nl>
References: <5.2.1.1.2.20030815135013.01b05bf8@oscarmayer.east.sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <5.2.1.1.2.20030815135013.01b05bf8@oscarmayer.east.sun.com>; from Peter.Nishimoto@Sun.COM on Fri, Aug 15, 2003 at 01:55:59PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 15, 2003 at 01:55:59PM -0400, Pete Nishimoto wrote:

>          My name is Pete Nishimoto and I work for Sun Microsystems
>          as a linux device driver developer, currently working with
>          RedHat 9.0 (2.4.20-8) and I believe I have found a problem
>          with the partitioning logic and the pager, which I've
>          detailed below.  I look forward to any replies/comments
>          and thanks in advance to all who review/read this.

Hi. You sent a long story, but at first sight it seems not relevant
for this linux-kernel mailing list.

A disk is made by a manufacturer, and has a number of sectors that we
must regard as given. If a filesystem is created on this disk then
often the disk size will turn out not to be precisely an integral
number of filesystem blocks.

Many people first partition the disk in some more or less arbitrary way.
Partitions may belong to other operating systems. Again we have no control.

In short, absolutely nothing is wrong if a disk, or a partition, has a size
that is not an integral number of filesystem blocks.

You talk about badblocks, but that is a userspace utility. If something
is wrong with it, that is not a kernel matter. Moreover, this utility
allows one to specify blocksize and last block to test.

So - the relevance to the kernel is not clear to me.

Concerning "RedHat 9.0 (2.4.20-8)" - discussion about vendor specific kernels
is probably best done on vendor lists.

Andries

