Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964916AbVKVLRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964916AbVKVLRa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 06:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbVKVLRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 06:17:30 -0500
Received: from mail.fh-wedel.de ([213.39.232.198]:17128 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S964916AbVKVLR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 06:17:29 -0500
Date: Tue, 22 Nov 2005 12:17:19 +0100
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: jdow <jdow@earthlink.net>
Cc: Matthias Andree <matthias.andree@gmx.de>, linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051122111719.GB14269@wohnheim.fh-wedel.de>
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com> <20051121101959.GB13927@wohnheim.fh-wedel.de> <20051121114654.GA25180@merlin.emma.line.org> <1132574831.15938.14.camel@localhost> <20051121131832.GB26068@merlin.emma.line.org> <008801c5eedc$f7277060$1225a8c0@kittycat>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <008801c5eedc$f7277060$1225a8c0@kittycat>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 November 2005 12:48:44 -0800, jdow wrote:
>
> that was seldom if ever used by real people. I am not sure how I would
> apply a checksum to each block of a file and still maintain reasonable
> access speeds. It would be entertaining to see what the ZFS file system
> does in this regard so that it doesn't slow down to essentially single
> block per transaction disk reads or huge RAM buffer areas such as had
> to be used with OFS.

Design should be just as ZFS alledgedly does it.  Store the checksum
near the indirect block pointers.  Seeks for checksums basically don't
exist, as you need to seek for the indirect block pointers anyway.
Only drawback is the effective growth of the area for the
pointers+checksum blocks, which has a small impact on your caches.

Jörn

-- 
Courage is not the absence of fear, but rather the judgement that
something else is more important than fear.
-- Ambrose Redmoon
