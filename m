Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267402AbUBSWec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 17:34:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267405AbUBSWec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 17:34:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49051 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267402AbUBSWe0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 17:34:26 -0500
From: Daniel Phillips <phillips@arcor.de>
To: "Stephen C. Tweedie" <sct@redhat.com>
Subject: Re: Non-GPL export of invalidate_mmap_range
Date: Thu, 19 Feb 2004 17:31:33 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Stephen Tweedie <sct@redhat.com>
References: <20040216190927.GA2969@us.ibm.com> <200402191531.56618.phillips@arcor.de> <1077228402.2070.893.camel@sisko.scot.redhat.com>
In-Reply-To: <1077228402.2070.893.camel@sisko.scot.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402191731.33473.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Thursday 19 February 2004 17:06, Stephen C. Tweedie wrote:
> Hi,
>
> On Thu, 2004-02-19 at 20:56, Daniel Phillips wrote:
> > OpenGFS and Sistina GFS use zap_page_range directly, essentially doing
> > the same as invalidate_mmap_range but skipping any vmas belonging to
> > MAP_PRIVATE mmaps.
>
> Well, MAP_PRIVATE maps can contain shared pages too --- any page in a
> MAP_PRIVATE map that has been mapped but not yet written to is still
> shared, and still needs shot down on truncate().

Exactly, and we ought to take this opportunity to do that properly, which is 
easy.  I'm just curious how GPFS deals with this issue, or if it simply 
doesn't support MAP_PRIVATE.

Regards,

Daniel

