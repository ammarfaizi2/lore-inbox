Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269225AbUINJDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269225AbUINJDY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 05:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269224AbUINJC4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 05:02:56 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:40579 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S269226AbUINJBI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 05:01:08 -0400
Date: Tue, 14 Sep 2004 11:00:50 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: William Lee Irwin III <wli@holomorphy.com>
cc: Alex Zarochentsev <zam@namesys.com>, Hugh Dickins <hugh@veritas.com>,
       Paul Jackson <pj@sgi.com>, Hans Reiser <reiser@namesys.com>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: 2.6.9-rc1-mm4 sparc reiser4 build broken - undefined
 atomic_sub_and_test
In-Reply-To: <20040914020614.GI9106@holomorphy.com>
Message-ID: <Pine.LNX.4.61.0409141055000.877@scrub.home>
References: <Pine.LNX.4.61.0409131608530.877@scrub.home>
 <Pine.LNX.4.44.0409131545100.17907-100000@localhost.localdomain>
 <20040913171936.GC2252@backtop.namesys.com> <20040914020614.GI9106@holomorphy.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 13 Sep 2004, William Lee Irwin III wrote:

> > I just like to know what atomic.h common functions would be in 2.6.9+,
> > because nowdays the API is not consisent accross the arches. 
> > atomic_sub_return() is OK.
> 
> sparc32 is very legacy;

Sparc is not really relevant in this case, as it basically uses 
atomic_sub_return() anyway, but i386 or m68k can benefit from avoiding 
atomic_sub_return() if it's possible and that not only in reiserfs.

bye, Roman
