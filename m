Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262008AbUEJXYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262008AbUEJXYm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 19:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261752AbUEJXRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 19:17:12 -0400
Received: from phoenix.infradead.org ([213.86.99.234]:32017 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263045AbUEJXOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 19:14:20 -0400
Date: Tue, 11 May 2004 00:14:18 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: Andrew Morton <akpm@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm1
Message-ID: <20040511001418.A9065@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Chris Wedgwood <cw@f00f.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20040510024506.1a9023b6.akpm@osdl.org> <20040510223755.A7773@infradead.org> <20040510150203.3257ccac.akpm@osdl.org> <20040510231146.GA5168@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040510231146.GA5168@taniwha.stupidest.org>; from cw@f00f.org on Mon, May 10, 2004 at 04:11:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 10, 2004 at 04:11:46PM -0700, Chris Wedgwood wrote:
> eh? magic groups are nasty...  and why is this needed?  can't
> oracle/whatever just run with a wrapper to give the capabilities out
> as required until a better solution is available

Well, easiest thing would be to use mmap on hugetlbfs in oracle, then
you just need to chown /dev/hugetlb/ group hugetlb and set +x for the
group - same effect as the kernel hack but keeping policy where it
belongs.

