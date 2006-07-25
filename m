Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964815AbWGYS2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964815AbWGYS2K (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 14:28:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751468AbWGYS2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 14:28:10 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33173 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751469AbWGYS2I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 14:28:08 -0400
Message-ID: <44C66296.2010109@sandeen.net>
Date: Tue, 25 Jul 2006 13:27:34 -0500
From: Eric Sandeen <sandeen@sandeen.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>, jack@suse.cz,
       20@madingley.org, marcel@holtmann.org, linux-kernel@vger.kernel.org,
       sct@redhat.com, adilger@clusterfs.com
Subject: Re: Bad ext3/nfs DoS bug
References: <20060718145614.GA27788@circe.esc.cam.ac.uk>	<1153236136.10006.5.camel@localhost>	<20060718152341.GB27788@circe.esc.cam.ac.uk>	<1153253907.21024.25.camel@localhost>	<20060719092810.GA4347@circe.esc.cam.ac.uk>	<20060719155502.GD3270@atrey.karlin.mff.cuni.cz>	<17599.2754.962927.627515@cse.unsw.edu.au>	<20060720160639.GF25111@atrey.karlin.mff.cuni.cz>	<17600.30372.397971.955987@cse.unsw.edu.au>	<20060721170627.4cbea27d.akpm@osdl.org>	<20060722131759.GC7321@thunk.org>	<20060724185604.9181714c.akpm@osdl.org> <17605.33733.51148.46400@cse.unsw.edu.au>
In-Reply-To: <17605.33733.51148.46400@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

> Putting it another way,
>  ext3_get_dentry reject certain inums that are known to be a problem.
>  ext2_get_dentry allows only those inums that could possibly be ok.
> 
> So if you (anyone) prefer one approach over the other, making the
> change so they both fs take the same approach would be trivial.

I like the 2nd approach - seems simpler, takes care of everything in 
->get_dentry, right?.  But I think your original patch is all that will 
work for 2.4 kernels...

-Eric
