Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267433AbUG2KD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267433AbUG2KD1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 06:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264305AbUG2KD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 06:03:27 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:53158 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S267433AbUG2KDH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 06:03:07 -0400
Date: Thu, 29 Jul 2004 10:35:43 +0200
From: Pavel Machek <pavel@ucw.cz>
To: David Brownell <david-b@pacbell.net>
Cc: Alexander Gran <alex@zodiac.dnsalias.org>, linux-kernel@vger.kernel.org
Subject: Re: fixing usb suspend/resuming
Message-ID: <20040729083543.GG21889@openzaurus.ucw.cz>
References: <200405281406.10447@zodiac.zodiac.dnsalias.org> <40F962B6.3000501@pacbell.net> <200407190927.38734@zodiac.zodiac.dnsalias.org> <200407202205.37763.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407202205.37763.david-b@pacbell.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > I'm suspecting that something is mistranslating between ACPI
> > > power state numbering and PCI power state numbering
> > 
> > ACK.
> 
> See http://bugme.osdl.org/show_bug.cgi?id=2886 ... basically
> it looks like this problem would show up with any of a dozen
> or so different drivers, few of which are widely used on systems
> that use suspend/resume much (laptops!).

Ben H. has some ideas how to fix this. Anyway, storing S-state or D-state in
integer is bad because someone will get it wrong.

Plus, some PCI drivers (ide disk?) want to do different thing on S3 and swsusp:
it does not make much sense to spindown before swsusp.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

