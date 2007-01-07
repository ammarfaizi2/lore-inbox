Return-Path: <linux-kernel-owner+w=401wt.eu-S932557AbXAGPG4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbXAGPG4 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 10:06:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932569AbXAGPG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 10:06:56 -0500
Received: from khc.piap.pl ([195.187.100.11]:41093 "EHLO khc.piap.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932557AbXAGPGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 10:06:55 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: git@vger.kernel.org, nigel@nigel.suspend2.net,
       "J.H." <warthog9@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>,
       kernel list <linux-kernel@vger.kernel.org>, webmaster@kernel.org
Subject: Re: How git affects kernel.org performance
References: <20061214223718.GA3816@elf.ucw.cz>
	<20061216094421.416a271e.randy.dunlap@oracle.com>
	<20061216095702.3e6f1d1f.akpm@osdl.org> <458434B0.4090506@oracle.com>
	<1166297434.26330.34.camel@localhost.localdomain>
	<1166304080.13548.8.camel@nigel.suspend2.net>
	<459152B1.9040106@zytor.com>
	<1168140954.2153.1.camel@nigel.suspend2.net>
	<45A08269.4050504@zytor.com> <45A083F2.5000000@zytor.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Sun, 07 Jan 2007 16:06:50 +0100
In-Reply-To: <45A083F2.5000000@zytor.com> (H. Peter Anvin's message of "Sat, 06 Jan 2007 21:24:02 -0800")
Message-ID: <m3odpazxit.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> During extremely high load, it appears that what slows kernel.org down
> more than anything else is the time that each individual getdents()
> call takes.  When I've looked this I've observed times from 200 ms to
> almost 2 seconds!  Since an unpacked *OR* unpruned git tree adds 256
> directories to a cleanly packed tree, you can do the math yourself.

Hmm... Perhaps it should be possible to push git updates as a pack
file only? I mean, the pack file would stay packed = never individual
files and never 256 directories?

People aren't doing commit/etc. activity there, right?
-- 
Krzysztof Halasa
