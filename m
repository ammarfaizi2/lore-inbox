Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267580AbUBSWHd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 17:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267582AbUBSWHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 17:07:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:45703 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267580AbUBSWG5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 17:06:57 -0500
Subject: Re: Non-GPL export of invalidate_mmap_range
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Daniel Phillips <phillips@arcor.de>
Cc: Andrew Morton <akpm@osdl.org>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <200402191531.56618.phillips@arcor.de>
References: <20040216190927.GA2969@us.ibm.com>
	 <20040217124001.GA1267@us.ibm.com> <20040217161929.7e6b2a61.akpm@osdl.org>
	 <200402191531.56618.phillips@arcor.de>
Content-Type: text/plain
Organization: 
Message-Id: <1077228402.2070.893.camel@sisko.scot.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Feb 2004 22:06:42 +0000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 2004-02-19 at 20:56, Daniel Phillips wrote:

> OpenGFS and Sistina GFS use zap_page_range directly, essentially doing the 
> same as invalidate_mmap_range but skipping any vmas belonging to MAP_PRIVATE 
> mmaps.

Well, MAP_PRIVATE maps can contain shared pages too --- any page in a
MAP_PRIVATE map that has been mapped but not yet written to is still
shared, and still needs shot down on truncate().

--Stephen


