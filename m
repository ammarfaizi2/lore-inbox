Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266533AbUBGDDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 22:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266546AbUBGDDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 22:03:46 -0500
Received: from pirx.hexapodia.org ([65.103.12.242]:15279 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S266533AbUBGDDo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 22:03:44 -0500
Date: Fri, 6 Feb 2004 21:03:43 -0600
From: Andy Isaacson <adi@hexapodia.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: avoiding dirty code pages with fixups
Message-ID: <20040207030343.GB21565@hexapodia.org>
References: <20040203225453.GB18320@hexapodia.org> <20040207001317.GE12503@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207001317.GE12503@mail.shareable.org>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 07, 2004 at 12:13:17AM +0000, Jamie Lokier wrote:
> > The downside is the additional computation on page-in.
> 
> > It is a function of how many fixups there are per page, and of how
> > much work ld.so does to satisfy a fixup.  I don't have a good feel
> > for how expensive ld.so's fixup mechanism is... any comments?
> 
> The other downside of your idea is that every instance of a program
> has more dirty pages.  While it is true that the pages do not require
> disk I/O, they still take up RAM that could be used for other page
> cache things.

Well, in the case I describe, currently they're done with MAP_PRIVATE
mappings, so it's no net loss.

-andy
