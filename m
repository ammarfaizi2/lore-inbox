Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758454AbWK0R4u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758454AbWK0R4u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 12:56:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758499AbWK0R4u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 12:56:50 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:39636 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S1758450AbWK0R4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 12:56:49 -0500
Date: Mon, 27 Nov 2006 18:56:47 +0100
To: Alan <alan@lxorguk.ukuu.org.uk>
Cc: avl@logic.at, linux-kernel@vger.kernel.org
Subject: Re: Allow turning off hpa-checking.
Message-ID: <20061127175647.GD2352@gamma.logic.tuwien.ac.at>
Reply-To: avl@logic.at
References: <20061120165601.GS6851@gamma.logic.tuwien.ac.at> <20061120172812.64837a0a@localhost.localdomain> <20061121115117.GU6851@gamma.logic.tuwien.ac.at> <20061121120614.06073ce8@localhost.localdomain> <20061122105735.GV6851@gamma.logic.tuwien.ac.at> <20061123170557.GY6851@gamma.logic.tuwien.ac.at> <20061127130953.GA2352@gamma.logic.tuwien.ac.at> <20061127133044.28b8b4ed@localhost.localdomain> <20061127160144.GB2352@gamma.logic.tuwien.ac.at> <20061127163328.3f1c12eb@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061127163328.3f1c12eb@localhost.localdomain>
User-Agent: Mutt/1.3.28i
From: Andreas Leitgeb <avl@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2006 at 04:33:28PM +0000, Alan wrote:
> > So after real remaining capacity has dropped
> > below original capacity,  querying the "native" size still
> > returns the original size, which is no longer physically
> > backed.
> This is incorrect.

Please, also give some hints, what actually falsifies my 
observation-based speculations. I surely don't insist in them
being accurate, but I try to understand what's really going on.

What else (if not sector remapping) could make the "current"
size gradually smaller between reboots. And why is "native"
size still constant?  And why does now even access to the but-last
native sector fail? The explanation with block-reads no longer
works.

> This is a matter for the partitioning tool. You don't know at boot time
> what you wish to do with the HPA so a boot option is inappropriate.

If I boot linux (e.g. from CD) on some precious windows-machine,
I do know that at boot time. Ditto if I connect a foreign
windows-disk in my machine (ata is afaik not yet hot-pluggable),
I'm also bound to know that at boot time.

There are also user-land tools (using ioctl) to manipulate 
this, in case I change my mind lateron.

How should the partitioning tool know, if I want to ignore the
HPA, or respect it (knowing it contains stuff that I might need in
future).  Does there exist any that asks me?
