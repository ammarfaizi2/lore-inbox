Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277231AbRJVRdU>; Mon, 22 Oct 2001 13:33:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277214AbRJVRcV>; Mon, 22 Oct 2001 13:32:21 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:5637 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S277230AbRJVRbf>; Mon, 22 Oct 2001 13:31:35 -0400
Message-ID: <3BD45631.78C4D16F@zip.com.au>
Date: Mon, 22 Oct 2001 10:24:01 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.13-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] binfmt_misc.c, kernel-2.4.12
In-Reply-To: <010801c15abe$ced47240$0100050a@abartoszko> <Pine.GSO.4.21.0110220242290.2294-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> ...
> Check that your modules.conf contains
> 
> post-install binfmt_misc mount -t binfmt_misc none /proc/sys/binfmt_misc
> pre-remove binfmt_misc umount /proc/sys/binfmt_misc
> 

Why is it necessary that the new binfmt_misc create its own
filesystem type, when all it seems to need is a couple of
/proc entries?
