Return-Path: <linux-kernel-owner+w=401wt.eu-S965089AbWL2Suz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965089AbWL2Suz (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 13:50:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbWL2Suz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 13:50:55 -0500
Received: from baikonur.stro.at ([213.239.196.228]:1304 "EHLO baikonur.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965089AbWL2Suy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 13:50:54 -0500
Date: Fri, 29 Dec 2006 19:52:15 +0100
From: maximilian attems <maks@sternwelten.at>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 file content corruption on ext3
Message-ID: <20061229185215.GS21469@baikonur.stro.at>
References: <20061228193943.GC8940@redhat.com> <20061229092314.GB24061@nancy> <20061229150253.GB4516@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061229150253.GB4516@redhat.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 29, 2006 at 10:02:53AM -0500, Dave Jones wrote:
> On Fri, Dec 29, 2006 at 10:23:14AM +0100, maximilian attems wrote:
>  > > On Thu, Dec 28, 2006 at 11:21:21AM -0800, Linus Torvalds wrote:
<snipp>
>  > >  > > That was a Fedora kernel. Has anyone seen the corruption in vanilla 2.6.18
>  > >  > > (or older)?
>  > >  > 
>  > >  > Well, that was a really _old_ fedora kernel. I guarantee you it didn't 
>  > >  > have the page throttling patches in it, those were written this summer. So 
>  > >  > it would either have to be Fedora carrying around another patch that just 
>  > >  > happens to result in the same corruption for _years_, or it's the same 
>  > >  > bug.
>  > > 
>  > > The only notable VM patch in Fedora kernels of that vintage that I recall
>  > > was Ingo's 4g/4g thing.
>  > 
>  > no the fedora 2.6.18 kernel is affected.
> 
> I wasn't denying that, but Linus was talking about a 2.6.5 Fedora kernel.
> 
>  > it carries the same -mm patches that Debian backported
>  > for LSB 3.1 compliance.
> 
> The only -mm stuff I recall being in the Fedora 2.6.18 is
> the inode-diet stuff which ended up in 2.6.19, though the xmas
> break has left my head somewhat empty so I may be forgetting something.
> What patch in particular are you talking about?

it's no longer visible in the FC6 cvs, due to rebase
 but it's name was linux-2.6-mm-tracking-dirty-pages.patch
it is an earlier almagame of the merged patch serie:
   - mm: tracking shared dirty pages
   - mm: balance dirty pages
   - mm: optimize the new mprotect() code a bit
   - mm: small cleanup of install_page()
   - mm: fixup do_wp_page()
   - mm: msync() cleanup (closes: #394392)

--
maks
