Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290718AbSBGFJv>; Thu, 7 Feb 2002 00:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291110AbSBGFJn>; Thu, 7 Feb 2002 00:09:43 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:36618 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S290718AbSBGFJc>; Thu, 7 Feb 2002 00:09:32 -0500
Date: Thu, 7 Feb 2002 00:09:30 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __free_pages_ok oops
Message-ID: <20020207000930.A17125@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0202061844450.1856-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.21.0202061844450.1856-100000@localhost.localdomain>; from hugh@veritas.com on Wed, Feb 06, 2002 at 07:06:01PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2002 at 07:06:01PM +0000, Hugh Dickins wrote:
> Sorry, no solution, but maybe another oops in __free_pages_ok might help?

I haven't seen the original oops, but if this patch goes in, it 
reintroduces the problem where network drivers / others release 
pages from irq context causing a BUG().  See sendpage.

		-ben
