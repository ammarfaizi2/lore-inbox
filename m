Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932269AbWEAV2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbWEAV2Y (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 17:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWEAV2X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 17:28:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:13246 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932269AbWEAV2X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 17:28:23 -0400
Date: Tue, 2 May 2006 07:28:08 +1000
From: Nathan Scott <nathans@sgi.com>
To: Marcelo Tosatti <marcelo@kvack.org>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: O_DIRECT, ext3fs, kernel 2.4.32... again
Message-ID: <20060502072808.A1873249@wobbly.melbourne.sgi.com>
References: <20060427063249.GH761@DervishD> <20060501062058.GA16589@dmt> <20060501112303.GA1951@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20060501112303.GA1951@DervishD>; from lkml@dervishd.net on Mon, May 01, 2006 at 01:23:03PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 01:23:03PM +0200, DervishD wrote:
>     Hi Marcelo :)
> 
>  * Marcelo Tosatti <marcelo@kvack.org> dixit:
> > >     Shouldn't ext3fs return an error when the O_DIRECT flag is
> > > used in the open call? Is the open call userspace only and thus
> > > only libc can return such error? Am I misunderstanding the entire
> > > issue and this is a perfectly legal behaviour (allowing the open,
> > > failing in the read operation)?
> > 
> > Your interpretation is correct. It would be nicer for open() to
> > fail on fs'es which don't support O_DIRECT, but v2.4 makes such
> > check later at read/write unfortunately ;(
> 
>     Oops :(

Nothing else really make sense due to fcntl...
	fcntl(fd, F_SETFL, O_DIRECT);
...can happen at any time, to enable/disable direct I/O.

cheers.

-- 
Nathan
