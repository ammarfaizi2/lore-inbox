Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271884AbRHUWta>; Tue, 21 Aug 2001 18:49:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271883AbRHUWtU>; Tue, 21 Aug 2001 18:49:20 -0400
Received: from abasin.nj.nec.com ([138.15.150.16]:49418 "HELO
	abasin.nj.nec.com") by vger.kernel.org with SMTP id <S271885AbRHUWtJ>;
	Tue, 21 Aug 2001 18:49:09 -0400
From: Sven Heinicke <sven@research.nj.nec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15234.58734.200740.952923@abasin.nj.nec.com>
Date: Tue, 21 Aug 2001 18:49:18 -0400 (EDT)
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Daniel Phillips <phillips@bonn-fries.net>, linux-kernel@vger.kernel.org
Subject: Re: With Daniel Phillips Patch (was: aic7xxx with 2.4.9 on 7899P) 
In-Reply-To: <200108211719.f7LHIvY95432@aslan.scsiguy.com>
In-Reply-To: <15234.37073.974320.621770@abasin.nj.nec.com>
	<200108211719.f7LHIvY95432@aslan.scsiguy.com>
X-Mailer: VM 6.72 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Justin,

I've tried removing your check, for writing bonnie++ still reports
slower write times then IDE drive on the other system.  Daniel Phillips
was great at helping me notice a problem that was causing slow down
but not related to the aic7xxx driver, thus I am now trying the
7.4.8-ac8 kernel.

I made your change whe will get try to get my user to test the system
with and without your change.

     Sven

Justin T. Gibbs writes:
 > >Disk access is faster then before but still slower then the IDE
 > >drive.  Any ideas?
 > 
 > It could be the occasionall ordered tag that is sent to the drive to
 > prevent tag starvation.  If you search in drivers/scsi/aic7xxx/aic7xxx_linux.c
 > for "OTAG_THRESH" and make that if test always fail (add an "&& 0") you will
 > have effectively disabled this feature.  I should probably make it an option
 > that defaults to off.
 > 
 > --
 > Justin
