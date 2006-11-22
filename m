Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162051AbWKVK5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162051AbWKVK5n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 05:57:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967106AbWKVK5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 05:57:43 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:43437 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S967107AbWKVK5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 05:57:42 -0500
Date: Wed, 22 Nov 2006 11:57:35 +0100
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: avl@logic.at, linux-kernel@vger.kernel.org
Subject: Re: possible bug in ide-disk.c (2.6.18.2 but also older)
Message-ID: <20061122105735.GV6851@gamma.logic.tuwien.ac.at>
Reply-To: avl@logic.at
References: <20061120145148.GQ6851@gamma.logic.tuwien.ac.at> <20061120152505.5d0ba6c5@localhost.localdomain> <20061120165601.GS6851@gamma.logic.tuwien.ac.at> <20061120172812.64837a0a@localhost.localdomain> <20061121115117.GU6851@gamma.logic.tuwien.ac.at> <20061121120614.06073ce8@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061121120614.06073ce8@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: Andreas Leitgeb <avl@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2006 at 12:06:14PM +0000, Alan wrote:
> >      It would also do that, if I later accessed the last sector
> >      (e.g. dd if=/dev/hda ..., or by accessing a file that happens
> >      to be stored there per filesystem, if at all possible),
> >      not just during the initial GPT-check.
> Only ever seen during the partition check

Last evening I got my hands back on that machine,
checked the kernel-config, and saw that GPT was 
already *unselected*!
Actually, the whole "Advanced partition..."-bundle
was unchecked.

While I can't tell whether the disk has such a thing,
(The kernel used at partitioning time might have had
GPT enabled. the tool used was either fdisk or cfdisk,
I don't remember exactly, but never use anything else.
It's about 3 years since.)

Turning off GPT in the current kernel obviously
*does not* solve the problem. :-(

Anything else I could do, short of patching ide-disk.c?
