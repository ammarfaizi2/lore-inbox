Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262132AbVBAVuC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbVBAVuC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 16:50:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262135AbVBAVuC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 16:50:02 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:22722 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S262132AbVBAVt7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 16:49:59 -0500
Date: Sat, 22 Jan 2005 19:41:24 +0100
From: Pavel Machek <pavel@suse.cz>
To: Bartlomiej Zolnierkiewicz <bzolnier@elka.pw.edu.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [ide-dev 3/5] generic Power Management for IDE devices
Message-ID: <20050122184124.GL468@openzaurus.ucw.cz>
References: <Pine.GSO.4.58.0501220004050.23959@mion.elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.58.0501220004050.23959@mion.elka.pw.edu.pl>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Move PM code from ide-cd.c and ide-disk.c to IDE core so:
> * PM is supported for other ATAPI devices (floppy, tape)
> * PM is supported even if specific driver is not loaded

Why do you need to have state-machine? During suspend we are running
single-threaded, it should be okay to just do the calls directly.
				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

