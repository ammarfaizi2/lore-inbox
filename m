Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266502AbUBLRGo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 12:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266520AbUBLRGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 12:06:43 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:1920 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S266502AbUBLRGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 12:06:42 -0500
Date: Thu, 12 Feb 2004 17:16:33 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200402121716.i1CHGXLv000188@81-2-122-30.bradfords.org.uk>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200402121740.03974.robin.rosenberg.lists@dewire.com> 
References: <20040209115852.GB877@schottelius.org>
 <200402121655.39709.robin.rosenberg.lists@dewire.com>
 <200402121617.i1CGHH2c000275@81-2-122-30.bradfords.org.uk>
 <200402121740.03974.robin.rosenberg.lists@dewire.com>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Robin Rosenberg <robin.rosenberg.lists@dewire.com>:
> On Thursday 12 February 2004 17.17, you wrote:
> > Another thing to consider is that you can encode the same character in
> > several ways using utf8, so two filenames could have different byte
> > strings, but evaluate to the same set of unicode characters.
> 
> No. That's not UTF-8.

Please don't break the CC list on replies.

I'm not sure whether it's valid UTF-8 or not, but it's certainly
possible to code, for example, an 'A', (decimal 65), via an escape to
a 31-bit character representation.  Presumably the majority of UTF-8
parsers would decode the sequence as 65, rather than emit an error.

Also, even ignoring that, how do you handle things like accented
characters which can be represented as single characters, or as
sequences containing combining characters?  Some applications might
convert the sequence containing combining characters in to the single
character, and others might not.

John.
