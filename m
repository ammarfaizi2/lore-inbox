Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262202AbSIZG2j>; Thu, 26 Sep 2002 02:28:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262203AbSIZG2j>; Thu, 26 Sep 2002 02:28:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:60035 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262202AbSIZG2i>;
	Thu, 26 Sep 2002 02:28:38 -0400
Date: Wed, 25 Sep 2002 23:27:41 -0700 (PDT)
Message-Id: <20020925.232741.02300012.davem@redhat.com>
To: akpm@digeo.com
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] deadline io scheduler
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D92A61E.40BFF2D0@digeo.com>
References: <20020925172024.GH15479@suse.de>
	<3D92A61E.40BFF2D0@digeo.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrew Morton <akpm@digeo.com>
   Date: Wed, 25 Sep 2002 23:15:58 -0700
   
   I'd like to gain a solid understanding of what these three knobs do.
   Could you explain that a little more?

My basic understanding of fifo_batch is:

1) fifo_batch is how many contiguous requests can be in
   a "set"

2) we send out one write "set" for every two read "sets"

3) a seek works out to "seek_cost" contiguous requests,
   cost wise, this gets subtracted from how many requests
   the current "set" has left that are allowed to be used
