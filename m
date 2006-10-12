Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030697AbWJLH2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030697AbWJLH2q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 03:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030700AbWJLH2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 03:28:46 -0400
Received: from mx1.redhat.com ([66.187.233.31]:22974 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030697AbWJLH2p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 03:28:45 -0400
Date: Thu, 12 Oct 2006 03:28:35 -0400
From: Dave Jones <davej@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Michael Harris <googlegroups@mgharris.com>, linux-kernel@vger.kernel.org,
       Hugh Dickins <hugh@veritas.com>
Subject: Re: 2.6.18: Kernel BUG at mm/rmap.c:522
Message-ID: <20061012072835.GA9274@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Andrew Morton <akpm@osdl.org>,
	Michael Harris <googlegroups@mgharris.com>,
	linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>
References: <20061011160740.GA6868@dingu.igconcepts.com> <20061012000026.8b6ea2e5.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061012000026.8b6ea2e5.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2006 at 12:00:26AM -0700, Andrew Morton wrote:
 
 > > ----------------
 > > Oct 11 04:53:35 hen kernel: VM: killing process cc1
 > > Oct 11 04:53:35 hen kernel: swap_free: Unused swap offset entry 00004000
 > > Oct 11 04:53:35 hen kernel: Eeek! page_mapcount(page) went negative! (-1)
 > > Oct 11 04:53:35 hen kernel:   page->flags = c0080014
 > > Oct 11 04:53:35 hen kernel:   page->count = 0
 > > Oct 11 04:53:35 hen kernel:   page->mapping = 00000000
 > > Oct 11 04:53:35 hen kernel: ------------[ cut here ]------------
 > > Oct 11 04:53:35 hen kernel: kernel BUG at mm/rmap.c:522!
 > 
 > Does that machine run any earlier kernels OK?  If so, which?

FWIW, I've seen a bunch of reports of this being triggered in Fedora bugzilla
which have had the nvidia module loaded.  Is that the case here ?

	Dave

-- 
http://www.codemonkey.org.uk
