Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268058AbUJJCbb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268058AbUJJCbb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 22:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268072AbUJJCbb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 22:31:31 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:2466 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S268058AbUJJCb2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 22:31:28 -0400
Date: Sun, 10 Oct 2004 03:31:26 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Jon Smirl <jonsmirl@gmail.com>
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [patch] drm core internal versioning..
In-Reply-To: <9e47339104100917527993026d@mail.gmail.com>
Message-ID: <Pine.LNX.4.58.0410100328080.11219@skynet>
References: <Pine.LNX.4.58.0410100050160.6083@skynet>
 <9e47339104100917527993026d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> How strong of match requirement do we need? Note that this only
> impacts distribution of binary personality modules, if you have source
> there is no problem.

Not really I'm thinking more of someone building a module against one core
and insmodding it against another one.. so someone builds a kernel with
core/personality, then builds just a personality module from CVS and tries
to use it with the kernel core one...

personally I think binary distributors have the money to keep up with the
kernel releases....

I don't want to re-implement kernel modversions which is what we are close
to doing, you can't insmod a module built against a different kernel
anyways so it doesn't matter, kernel version, preempt, smp, compiler are
all checked on insmod in 2.6 if they don't match it doesn't load it is not
possible to distrib a binarry kernel independent module.. without at least
a portable stub source loader...

Dave.

-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

