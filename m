Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264476AbTEaWQU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 May 2003 18:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264478AbTEaWQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 May 2003 18:16:20 -0400
Received: from h68-147-142-75.cg.shawcable.net ([68.147.142.75]:23536 "EHLO
	schatzie.adilger.int") by vger.kernel.org with ESMTP
	id S264476AbTEaWQT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 May 2003 18:16:19 -0400
Date: Sat, 31 May 2003 16:29:34 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Philippe Amelant <philippe.amelant@free.fr>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 /dev/random problem
Message-ID: <20030531162934.A1522@schatzie.adilger.int>
Mail-Followup-To: Philippe Amelant <philippe.amelant@free.fr>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1054395393.20196.211.camel@smp-tux.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1054395393.20196.211.camel@smp-tux.free.fr>; from philippe.amelant@free.fr on Sat, May 31, 2003 at 05:36:34PM +0200
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On May 31, 2003  17:36 +0200, Philippe Amelant wrote:
> I have a compaq server with a little problem.
> cat /proc/sys/kernel/random/entropy_avail is always 0
> so /dev/random block on all read.
> 
> I have read some discussion about /dev/random on this list.
> and if I understand /dev/urandom rely on /dev/random for providing good
> randomness and /dev/random rely on server activity for it's entropy.
> 
> But I don't understand why my disk activity doesn't refill the entropy
> counter. If I try to mount floppy I get some entropy but even updating
> locate db does not provide any entropy ? Should I activate something in
> disk driver ?

Maybe you only have disk drives attached via CCISS or other special
RAID controller, and you do not use keyboard or mouse?  It might be
that the RAID controller is not contributing to the entopy pool.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

