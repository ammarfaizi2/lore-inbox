Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263166AbTJPUm6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Oct 2003 16:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263170AbTJPUm5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Oct 2003 16:42:57 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:23799 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263166AbTJPUm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Oct 2003 16:42:56 -0400
Date: Thu, 16 Oct 2003 14:40:33 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Matt Mackall <mpm@selenic.com>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Eli Billauer <eli_billauer@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
Subject: Re: [RFC] frandom - fast random generator module
Message-ID: <20031016144033.H7000@schatzie.adilger.int>
Mail-Followup-To: Matt Mackall <mpm@selenic.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	Eli Billauer <eli_billauer@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, Nick Piggin <piggin@cyberone.com.au>
References: <3F8E552B.3010507@users.sf.net> <3F8E58A9.20005@cyberone.com.au> <3F8E70E0.7070000@users.sf.net> <3F8E8101.70009@pobox.com> <20031016102020.A7000@schatzie.adilger.int> <3F8EC7D0.5000003@pobox.com> <20031016121825.D7000@schatzie.adilger.int> <20031016193110.GR5725@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031016193110.GR5725@waste.org>; from mpm@selenic.com on Thu, Oct 16, 2003 at 02:31:10PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 16, 2003  14:31 -0500, Matt Mackall wrote:
> On Thu, Oct 16, 2003 at 12:18:25PM -0600, Andreas Dilger wrote:
> > 	while (nbytes >= sizeof(*data)) {
> > 		*(long *)buf = *data;
> > 		buf += sizeof(*data);
> > 		*data = *data * 1812433253L + 12345L; /* or whatever... */
> > 	}
> 
> I don't think a get_pseudorandom_bytes() is a horrible idea. But it's
> still worth the trouble to pick a more robust pseudorandom generator.
> The above won't satisfy common spectral requirements. I'd rather try
> to make /dev/urandom suffice first though.

Oh, by all means the above isn't sufficient, just an example.  We have
already had 2 arch-specific assembly PRNGs that are much better than
the above that can be used if there is no HW RNG.  My point was that it
would be nice to hide the details of which PRNG and all the CPU selection
and config detection from callers in the kernel.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

