Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313940AbSDPW6t>; Tue, 16 Apr 2002 18:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313939AbSDPW6r>; Tue, 16 Apr 2002 18:58:47 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:61683 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S313938AbSDPW6n>; Tue, 16 Apr 2002 18:58:43 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 16 Apr 2002 16:56:31 -0600
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why HZ on i386 is 100 ?
Message-ID: <20020416225631.GD20464@turbolinux.com>
Mail-Followup-To: Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020416222156.GB20464@turbolinux.com> <E16xba3-0005tw-00@gondolin.me.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 17, 2002  08:37 +1000, Herbert Xu wrote:
> Why are we still measuring uptime using the tick variable? Ticks != time.
> Surely we should be recording the boot time somewhere (probably on a
> file system), and then comparing that with the current time?

Er, because the 'tick' is a valid count of the actual time that the
system has been running, while the "boot time" is totally meaningless.
What if the system has no RTC, or the RTC is wrong until later in the
boot sequence when it can be set by the user/ntpd?  What if you pass
daylight savings time?  Does your uptime increase/decrease by an hour?

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

