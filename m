Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261234AbUIIMLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbUIIMLI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 08:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261474AbUIIMLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 08:11:08 -0400
Received: from unthought.net ([212.97.129.88]:36299 "EHLO unthought.net")
	by vger.kernel.org with ESMTP id S261234AbUIIMLC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 08:11:02 -0400
Date: Thu, 9 Sep 2004 14:11:00 +0200
From: Jakob Oestergaard <jakob@unthought.net>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Major XFS problems...
Message-ID: <20040909121100.GN390@unthought.net>
Mail-Followup-To: Jakob Oestergaard <jakob@unthought.net>,
	Nathan Scott <nathans@sgi.com>, linux-xfs@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20040908123524.GZ390@unthought.net> <20040909074046.A3958243@wobbly.melbourne.sgi.com> <20040908232210.GL390@unthought.net> <20040909094255.F3951028@wobbly.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909094255.F3951028@wobbly.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 09, 2004 at 09:42:55AM +1000, Nathan Scott wrote:
> Hi Jakob,
> 
...
> OK, so could you add the details on how you're managing to hit it
> into that bug?... when you say "trivially" - does that mean you
> have a recipe that is guaranteed to quickly hit it?  A reproducible
> test case would be extremely useful in tracking this down.

On the two systems where I've seen this, the recipe is to set up an
SMP+NFS+XFS server, and have a number of clients mount the exported
filesystem, then perform reads and writes...

The two servers are used very differently - one is holding a small
number of source trees that are compiled/linked on a small cluster. The
other is holding a very large number of user home directories, where the
primary use is web serving (web servers running on the NFS clients).

A google for 'debug.c:106' turns out some 120 results - it seems that no
special magic is needed, other than a few boxes to set up the test
scenario.

On the 29th of februrary, akp@cohaesio.com submitted (as comment #23 to
bug #309) a description of a test setup along with a shell script that
was used to trigger this problem.

-- 

 / jakob

