Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265667AbUBFSpV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 13:45:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265636AbUBFSoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 13:44:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:58752 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265654AbUBFSmK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 13:42:10 -0500
Date: Fri, 6 Feb 2004 10:42:00 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: viro@parcelfarce.linux.theplanet.co.uk
cc: John Cherry <cherry@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: IA32 (2.6.2 - 2004-02-05.22.30) - 3 New warnings (gcc 3.2.2)
In-Reply-To: <20040206182208.GI21151@parcelfarce.linux.theplanet.co.uk>
Message-ID: <Pine.LNX.4.58.0402061041190.30672@home.osdl.org>
References: <200402061122.i16BMZ10009537@cherrypit.pdx.osdl.net>
 <20040206113305.GF21151@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.58.0402060850380.30672@home.osdl.org>
 <20040206182208.GI21151@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Fri, 6 Feb 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> Umm...  How about
> 
> static inline void BUG() __attribute__((noreturn));
> 
> static inline void BUG(void)
> {
> 	__asm__ ....
> }

Did you try that? Last time I tried, gcc would complain every time it saw 
the thing about "noreturn function does return".

		Linus
