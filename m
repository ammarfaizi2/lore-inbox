Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292813AbSCVHtC>; Fri, 22 Mar 2002 02:49:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292840AbSCVHsv>; Fri, 22 Mar 2002 02:48:51 -0500
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:25596 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S292813AbSCVHsh>; Fri, 22 Mar 2002 02:48:37 -0500
From: Andreas Dilger <adilger@clusterfs.com>
Date: Fri, 22 Mar 2002 00:48:14 -0700
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org, Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Subject: Re: [PATCH] Trivial request_region check patchset.
Message-ID: <20020322074814.GC3451@turbolinux.com>
Mail-Followup-To: Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>
In-Reply-To: <E16oIJ7-0000uW-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 22, 2002  17:13 +1100, Rusty Russell wrote:
> 	Evgeniy Polyakov <johnpol@2ka.mipt.ru> has been working his
> way through the kernel, auditing request_region calls (which as of 2.4
> return an int).  Please peruse for your drivers before I send them all
> to Linus, and watch out for more mails from Evgeniy!

Thank you Evgeniy for this work.  A very minor change request - please
follow the kernel CodingStyle:

	if (!request_region(0xa0, 0x20, "pic2"))
		{
		release_region(0x20, 0x20);
		return;
		}

should be:

	if (!request_region(0xa0, 0x20, "pic2")) {
		release_region(0x20, 0x20);
		return;
	}

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

