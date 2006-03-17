Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932150AbWCQM3a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932150AbWCQM3a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 07:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWCQM3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 07:29:30 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:17605 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S932106AbWCQM33
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 07:29:29 -0500
Message-ID: <441AABBC.1060809@de.ibm.com>
Date: Fri, 17 Mar 2006 13:29:48 +0100
From: Carsten Otte <cotte@de.ibm.com>
Reply-To: carsteno@de.ibm.com
Organization: IBM Deutschland
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Jes Sorensen <jes@sgi.com>,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org, hch@lst.de,
       Hugh Dickins <hugh@veritas.com>, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [patch] mspec - special memory driver and do_no_pfn handler
References: <yq0k6auuy5n.fsf@jaguar.mkp.net> <20060316163728.06f49c00.akpm@osdl.org> <Pine.LNX.4.64.0603161659210.3618@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0603161659210.3618@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Quite frankly, I don't think nopfn() is a good interface. It's only usable 
> for one single thing, so trying to claim that it's a generic VM op is 
> really not valid. If (and that's a big if) we need this interface, we 
> should just do it inside mm/memory.c instead of playing games as if it was 
> generic.
Execute in place would be the second single thing we'll need it for. Also,
I remember a statement from Anrd that it has value for SPUfs on Cell which
does count as singe thing #3. With three single things at hand, I believe
there is some sense in makeing it "a generic thing".

Carsten
