Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbVJDK2i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbVJDK2i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 06:28:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbVJDK2i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 06:28:38 -0400
Received: from ookhoi.xs4all.nl ([213.84.114.66]:8598 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S932194AbVJDK2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 06:28:38 -0400
Date: Tue, 4 Oct 2005 12:28:35 +0200
From: Sander <sander@humilis.net>
To: Nigel Cunningham <ncunningham@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange disk corruption with Linux >= 2.6.13
Message-ID: <20051004102834.GA16755@favonius>
Reply-To: sander@humilis.net
References: <20050927111038.GA22172@ime.usp.br> <1127863912.4802.52.camel@localhost> <20051001213655.GE6397@ime.usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051001213655.GE6397@ime.usp.br>
X-Uptime: 12:06:48 up 58 days, 21:31, 28 users,  load average: 1.00, 1.00, 1.00
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rog?rio Brito wrote (ao):
> On Sep 28 2005, Nigel Cunningham wrote:
> > 3) Is the corruption only ever in memory, or seen on disk too?
> 
> I have noticed the problem mostly on disk. One strange situation was
> when I was untarring a kernel tree (compressed with bzip2) and in the
> middle of the extraction, bzip2 complained that the thing was
> corrupted.
> 
> I removed what was extracted right away and tried again to extract the
> tree (at this point, suspecting even that something in software had
> problems). The problem with bzip2 occurred again. Then, I rebooted the
> system an the problem magically went away.

That would mean the corruption existed in memory only. The kernel
tarball got sucked into memory and got corrupted. On reboot, the tarball
gets read in again, and this time no corruption. The on disk tarball was
oke it seems.

If you run memtest86+ (latest version) for at least 24 hours it _should_
find something.

	Kind regards, Sander

-- 
Humilis IT Services and Solutions
http://www.humilis.net
