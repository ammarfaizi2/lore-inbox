Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265930AbUGTOmV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265930AbUGTOmV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 10:42:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265928AbUGTOmV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 10:42:21 -0400
Received: from Mail.MNSU.EDU ([134.29.1.12]:55709 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S265930AbUGTOjZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 10:39:25 -0400
Message-ID: <40FD2E99.20707@mnsu.edu>
Date: Tue, 20 Jul 2004 09:39:21 -0500
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steve Lord <lord@xfs.org>
CC: Cahya Wirawan <cwirawan@email.archlab.tuwien.ac.at>,
       linux-kernel@vger.kernel.org
Subject: Re: 4K stack kernel get Oops in Filesystem stress test
References: <20040720114418.GH21918@email.archlab.tuwien.ac.at> <40FD0A61.1040503@xfs.org>
In-Reply-To: <40FD0A61.1040503@xfs.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve Lord wrote:

> Don't use 4K stacks and XFS. What you hit here is a path where the
> filesystem is getting full and it needs to free some reserved space
> by flushing cached data which is using reserved extents. Reserved
> extents do not yet have an on disk address and they include a
> reservation for the worst case metadata usage. Flushing them will
> get you room back.
>
> As you can see, it is a pretty deep call stack, most of XFS is going
> to work just fine with a 4K stack, but there are end cases like
> this one which will just not fit.


If this is a known truth with XFS maybe it would be a good idea to have 
4K stacks and XFS be an impossible combination using the config tool.

-- 
jeffrey hundstad
