Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbTIDI2j (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 04:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264805AbTIDI2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 04:28:39 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:28678 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264782AbTIDI2i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 04:28:38 -0400
Date: Thu, 4 Sep 2003 09:28:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>, paulus@samba.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix ppc ioremap prototype
Message-ID: <20030904092834.A27774@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, paulus@samba.org,
	linux-kernel@vger.kernel.org
References: <20030904010940.5fa0e560.davem@redhat.com> <Pine.LNX.4.44.0309040111290.20151-100000@home.osdl.org> <20030904011010.21857a1c.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030904011010.21857a1c.davem@redhat.com>; from davem@redhat.com on Thu, Sep 04, 2003 at 01:10:10AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 04, 2003 at 01:10:10AM -0700, David S. Miller wrote:
> What we could do in the interim is create an ioremap_resource()
> and then move things over gradually.

ioremap_resource() looks like a fine idea.  It's cleaner, easily
emulateable on <= 2.4 and solves the problem this hack wanted to
work around properly.

This still doesn't make the phys_addr_t a good interims solution,
though.  Just use ioremap_resource from the beginning for those
drivers that care for the bigger address space on ppc44x.

Paul, what does actually use this higher addresses?
