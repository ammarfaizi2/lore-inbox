Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTDNQJE (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 12:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263535AbTDNQJE (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 12:09:04 -0400
Received: from h68-147-110-38.cg.shawcable.net ([68.147.110.38]:25852 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S263528AbTDNQJD (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 12:09:03 -0400
Date: Mon, 14 Apr 2003 10:19:59 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: olarge -- force O_LARGEFILE on app binaries.
Message-ID: <20030414101959.E26054@schatzie.adilger.int>
Mail-Followup-To: Tigran Aivazian <tigran@veritas.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0304141554560.3687-100000@einstein31.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0304141554560.3687-100000@einstein31.homenet>; from tigran@veritas.com on Mon, Apr 14, 2003 at 04:03:32PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 14, 2003  16:03 +0100, Tigran Aivazian wrote:
> Some time ago I was annoyed to see that ghostscript didn't support large
> files (>2G) and, although the fix to gs(1) was trivial it was very
> undesirable to have to recompile it (for lots of reasons like mismatch
> between the source set and fonts, libraries etc). So the only (efficient)
> solution in my case would have been to "modify" the behaviour of the gs
> binary without rebuilding it. One way is to use LD_PRELOAD feature but I
> found it easier to just knock up a simple kernel module olarge.o to do the
> job.

I don't see how this helps you very much.  So now, instead of the kernel
complaining with EFBIG and/or SIGXFSZ, your 32-bit size offset wraps in
the application.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

