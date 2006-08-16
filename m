Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWHPWVp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWHPWVp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 18:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWHPWVp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 18:21:45 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932286AbWHPWVo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 18:21:44 -0400
Date: Wed, 16 Aug 2006 15:21:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Malte =?ISO-8859-1?Q?Schr=F6der?= <MalteSch@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs on-demand bitmap loading, what is the state?
Message-Id: <20060816152139.0752f406.akpm@osdl.org>
In-Reply-To: <200608161758.41935.MalteSch@gmx.de>
References: <200608161758.41935.MalteSch@gmx.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 17:58:38 +0200
Malte Schr__der <MalteSch@gmx.de> wrote:

> Hello,
> I set up a new raid system with about 500gib space and put reiserfs on it. It 
> takes some seconds to mount so I patched my 2.6.17.8-tree with those 
> reiserfs-patches from -mm. Mount time was reduced significantly (less than a 
> second).
> What I found out about these patches is that they can introduce instability, 
> but that seemed a bit vague to me.

The first version of the patches was (terribly) buggy.  The version in
current -mm has no known (to me) shortcomings.

> Up to now I didn't encounter any problems, so are there (theoretical?) 
> problems with the on-demand code? Could that stuff go into mainline?

Expect to see it in 2.6.19-rc1.

> Maybe there are tests I could run, the data on that box is easily 
> recoverable ...

Yup, please run tests - anything and everything.

Be sure to run reiserfsck before the testing to make sure the fs is clean,
then run it again at the end of testing, see if anything ended up out of
place.

