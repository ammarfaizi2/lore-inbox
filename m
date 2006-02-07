Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964911AbWBGCwk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964911AbWBGCwk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 21:52:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964913AbWBGCwk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 21:52:40 -0500
Received: from risc4.numis.northwestern.edu ([129.105.122.70]:53774 "EHLO
	risc4.numis.northwestern.edu") by vger.kernel.org with ESMTP
	id S964911AbWBGCwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 21:52:39 -0500
Date: Mon, 6 Feb 2006 20:52:39 -0600 (CST)
From: "L. D. Marks" <L-marks@northwestern.edu>
X-X-Sender: ldm@risc4.numis.northwestern.edu
Reply-To: "L. D. Marks" <L-marks@northwestern.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: Broken NFS (perhaps Cache invalidation bug ?)
In-Reply-To: <Pine.GHP.4.63.0602062038470.3104@risc4.numis.northwestern.edu>
Message-ID: <Pine.GHP.4.63.0602062050460.3104@risc4.numis.northwestern.edu>
References: <Pine.GHP.4.63.0602062038470.3104@risc4.numis.northwestern.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should have added the kernel: 2.6.9-22.0.2.ELsmp #1 SMP with 
nfs-utils-1.0.6-65.EL4


On Mon, 6 Feb 2006, L. D. Marks wrote:

> I have a problem which appears to be very similar to a cache invalidation bug 
> previously reported: 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0510.1/0582.html
>
> With a conventional nfs mount (not automount), c0-0 a client node, running on 
> the nfs server:
>
> echo 10 > Probe
> ssh -x c0-0 cat Probe
> echo 11 > Probe
> ssh -x c0-0 cat Probe
>
> Will give, most times, 10 & 10 rather than 10 & 11.
>
> I've tried a wide range of things (including consulting local experts), so 
> far nothing. I'm not a kernel developer, so please be gentle. This problem 
> has occurred ever since we moved to the 4.X releases of rocks 
> (http://www.rocksclusters.org), X=0 or 1 although it's hidden by their 
> default use of automounting and it's taken some time to reduce it to 
> something simple.
>
> -----------------------------------------------
> Laurence Marks
> Department of Materials Science and Engineering
> MSE Rm 2036 Cook Hall
> 2220 N Campus Drive
> Northwestern University
> Evanston, IL 60201, USA
> Tel: (847) 491-3996 Fax: (847) 491-7820
> email: L-marks at northwestern dot edu
> http://www.numis.northwestern.edu
> -----------------------------------------------
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Note: if you have an old email address for me, please note that "nwu" has
been changed to "northwestern".
-----------------------------------------------
Laurence Marks
Department of Materials Science and Engineering
MSE Rm 2036 Cook Hall
2220 N Campus Drive
Northwestern University
Evanston, IL 60201, USA
Tel: (847) 491-3996 Fax: (847) 491-7820
email: L-marks at northwestern dot edu
http://www.numis.northwestern.edu
-----------------------------------------------

