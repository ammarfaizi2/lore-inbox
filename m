Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263994AbUCZKAO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Mar 2004 05:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264000AbUCZKAO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Mar 2004 05:00:14 -0500
Received: from [211.167.76.68] ([211.167.76.68]:59308 "HELO soulinfo.com")
	by vger.kernel.org with SMTP id S263994AbUCZKAH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Mar 2004 05:00:07 -0500
Date: Fri, 26 Mar 2004 17:58:29 +0800
From: Hugang <hugang@soulinfo.com>
To: Christoph Hellwig <hch@infradead.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Problem with remap_page_range/mmap
Message-Id: <20040326175829.083d7e72@localhost>
In-Reply-To: <20040326094656.A3812@infradead.org>
References: <20040325234804.GA29507@core.home>
	<20040326071739.B2637@infradead.org>
	<20040326093619.GA15965@core.home>
	<20040326094656.A3812@infradead.org>
Organization: Beijing Soul
X-Mailer: Sylpheed version 0.9.8claws (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Checked: Checked
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Mar 2004 09:46:56 +0000
Christoph Hellwig <hch@infradead.org> wrote:

> On Fri, Mar 26, 2004 at 10:36:19AM +0100, Christian Leber wrote:
> > What would be the good idea? I need at least 8 at least 4MB (2MB are
> > enough for 2.4) big physical memory pieces for DMA, mapped to
> > userspace.
> > 
> > remap_page_range for ia64.
> 
> Put the page structs into an array and return them from ->nopage.  The
> kernel pagefault code will set up the ptes for you.
> 
> Now actually getting 4MB of continguous memory is a different issue..
> 
> I'm surprised you actually managed to get the allocation to succeed.

There is more detailed information about make page usable to user space,
http://www.xml.com/ldd/chapter/book/ch13.html

Hope that's useful.

-- 
Hu Gang / Steve
Linux Registered User 204016
GPG Public Key: http://soulinfo.com/~hugang/hugang.asc
