Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317759AbSGKEmz>; Thu, 11 Jul 2002 00:42:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317760AbSGKEmy>; Thu, 11 Jul 2002 00:42:54 -0400
Received: from dsl-213-023-020-124.arcor-ip.net ([213.23.20.124]:32491 "EHLO
	starship") by vger.kernel.org with ESMTP id <S317759AbSGKEmx>;
	Thu, 11 Jul 2002 00:42:53 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andreas Dilger <adilger@clusterfs.com>,
       Marc-Christian Petersen <mcp@linux-systeme.de>
Subject: Re: htree directory indexing 2.4.18-2 BUG with highmem and also high i/o
Date: Thu, 11 Jul 2002 00:46:23 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
References: <200207092333.01130.mcp@linux-systeme.de> <20020710210153.GA1045@clusterfs.com>
In-Reply-To: <20020710210153.GA1045@clusterfs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17SQE4-00029R-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 July 2002 23:01, Andreas Dilger wrote:
> On Jul 09, 2002  23:33 +0200, Marc-Christian Petersen wrote:
> > Hi Daniel,
> > 
> > I've found a bug with htree directory indexing patch and
> > highmem enabled (64GB). This is with 2.4.18 and htree patch
> > 2.4.18-2. Oops appears if accessing an ext2 partition with ls
> > or doing "who/w" in the directory of the ext2 partition.
> 
> The ext2 htree patch probably needs to add a "kmap()" and "kunmap()"
> in the function that reads a page and scans the directory for the
> name it is looking for.  I can't be any more specific than this
> right now since I only have the ext3 version of this patch, and it
> does not have page-cache based directories (it is still using the
> buffer cache).

Hi Andreas,

Yes, kmap is utterly not-there for the Ext2 version of the patch.
This is one of those uninteresting but altogether essential chores
that just needs doing.  Sigh.

See you tomorrow.

-- 
Daniel
