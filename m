Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268100AbUBRVKs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 16:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268103AbUBRVKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 16:10:47 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:27405 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S268100AbUBRVKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 16:10:46 -0500
Date: Wed, 18 Feb 2004 21:10:35 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Paul E. McKenney" <paulmck@us.ibm.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
       hch@infradead.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: Non-GPL export of invalidate_mmap_range
Message-ID: <20040218211035.A13866@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Paul E. McKenney" <paulmck@us.ibm.com>,
	Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20040216190927.GA2969@us.ibm.com> <20040217073522.A25921@infradead.org> <20040217124001.GA1267@us.ibm.com> <20040217161929.7e6b2a61.akpm@osdl.org> <1077108694.4479.4.camel@laptop.fenrus.com> <20040218140021.GB1269@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040218140021.GB1269@us.ibm.com>; from paulmck@us.ibm.com on Wed, Feb 18, 2004 at 06:00:21AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 18, 2004 at 06:00:21AM -0800, Paul E. McKenney wrote:
> There is a small shim layer required, but the bulk of the code
> implementing GPFS is common between AIX and Linux.  It was on AIX
> first by quite a few years.

Small glue layer?  Unfortunately ibm took it off the website, but
the thing is damn huge.

> > it only uses "core unix" apis ?
> 
> If they are made available, yes.  That is the point of this patch,
> after all.  ;-)

No, that's wrong.  It patches the syscall table and plays evilish
tricks with lowlevel MM code.

> > It doesn't require knowledge of deep and changing internals ? *buzz*
> 
> That is indeed the idea.

The one on the ibm website a little ago did.  You're free to upload
a new one that clearly doesn't need all this, but..


