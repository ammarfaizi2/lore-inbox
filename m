Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262409AbVESGrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262409AbVESGrL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 May 2005 02:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262421AbVESGrL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 May 2005 02:47:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:51873 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262409AbVESGrI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 May 2005 02:47:08 -0400
Date: Wed, 18 May 2005 23:46:57 -0700
From: Chris Wright <chrisw@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] prevent NULL mmap in topdown model
Message-ID: <20050519064657.GH23013@shell0.pdx.osdl.net>
References: <Pine.LNX.4.61.0505181556190.3645@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0505181535210.18337@ppc970.osdl.org> <Pine.LNX.4.61.0505182224250.29123@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0505181946300.2322@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505181946300.2322@ppc970.osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds (torvalds@osdl.org) wrote:
> However, it would be good to have even the trivial patch tested. 
> Especially since what it tries to fix is a total corner-case in the first 
> place..

I gave it a quick and simple test.  Worked as expected.  Last page got
mapped at 0x1000, leaving first page unmapped.  Of course, either with
MAP_FIXED or w/out MAP_FIXED but proper hint (like -1) you can still
map first page.  This isn't to say I was extra creative in testing.
