Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262856AbUCOXy7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 18:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbUCOXyy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 18:54:54 -0500
Received: from holomorphy.com ([207.189.100.168]:32005 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262856AbUCOXys (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 18:54:48 -0500
Date: Mon, 15 Mar 2004 15:54:09 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Ray Bryant <raybry@sgi.com>
Cc: Andrew Morton <akpm@osdl.org>, ak@suse.de, lse-tech@lists.sourceforge.net,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Hugetlbpages in very large memory machines.......
Message-ID: <20040315235409.GM655@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Ray Bryant <raybry@sgi.com>, Andrew Morton <akpm@osdl.org>,
	ak@suse.de, lse-tech@lists.sourceforge.net,
	linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <40528383.10305@sgi.com> <20040313034840.GF4638@wotan.suse.de> <20040313184547.6e127b51.akpm@osdl.org> <40541A09.3050600@sgi.com> <20040314005737.7f57b8ad.akpm@osdl.org> <405550F6.1070203@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <405550F6.1070203@sgi.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2004 at 12:45:10AM -0600, Ray Bryant wrote:
> I'd still rather see us do the "allocate on fault" approach with 
> prereservation to maintain the current ENOMEM return code from mmap()
> for hugepages. Let me work on that and get back to y'all with a patch
> and see where we can go from there.  I'll start by taking a look at
> all of the arch dependent hugetlbpage.c's and see how common they all
> are and move the common code up to mm/hugetlbpage.c.
> (or did WLI's note imply that this is impossible?)

It would be a mistake to put any pagetable handling functions in the
core. Things above that level, e.g. callers that don't examine the
pagetables directly in favor of calling lower-level API's, are fine.


-- wli
