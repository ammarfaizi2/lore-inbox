Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUBKUiV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 15:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266184AbUBKUiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 15:38:21 -0500
Received: from fw.osdl.org ([65.172.181.6]:52452 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264113AbUBKUiU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 15:38:20 -0500
Date: Wed, 11 Feb 2004 12:38:11 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Tim Hockin <thockin@sun.com>
cc: viro@parcelfarce.linux.theplanet.co.uk, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, viro@math.psu.edu
Subject: Re: PATCH - raise max_anon limit
In-Reply-To: <20040211203306.GI9155@sun.com>
Message-ID: <Pine.LNX.4.58.0402111236460.2128@home.osdl.org>
References: <20040206221545.GD9155@sun.com> <20040207005505.784307b8.akpm@osdl.org>
 <20040207094846.GZ21151@parcelfarce.linux.theplanet.co.uk>
 <20040211203306.GI9155@sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 11 Feb 2004, Tim Hockin wrote:

> > d) grab a couple of pages and be done with that.  That gives us 64Kbits.
> 
> Maybe that is just the simplest answer?  It can be a simple constant that is
> changeable at compile time, and leave it at that
> 
> What's most likely to cause the least argument?

I'd suggest just raising it to 64k or so, that's likely to be acceptable, 
and it's a static 8kB array. That's likely not much more than the code 
needed to worry about dynamic entries, yet I'd assume that changing it 
from 256 to 64k is going to make most people say "enough".

		Linus
