Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312426AbSDJDza>; Tue, 9 Apr 2002 23:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312431AbSDJDz3>; Tue, 9 Apr 2002 23:55:29 -0400
Received: from h24-67-14-151.cg.shawcable.net ([24.67.14.151]:20471 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S312426AbSDJDz2>; Tue, 9 Apr 2002 23:55:28 -0400
From: Andreas Dilger <adilger@clusterfs.com>
Date: Tue, 9 Apr 2002 21:53:12 -0600
To: Jeff Dike <jdike@karaya.com>
Cc: Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
        user-mode-linux-user@lists.sourceforge.net
Subject: Re: [uml-user] Re: user-mode port 0.56-2.4.18-15
Message-ID: <20020410035312.GG424@turbolinux.com>
Mail-Followup-To: Jeff Dike <jdike@karaya.com>,
	Pavel Machek <pavel@suse.cz>, linux-kernel@vger.kernel.org,
	user-mode-linux-user@lists.sourceforge.net
In-Reply-To: <20020409221716.GI5148@atrey.karlin.mff.cuni.cz> <200204100144.UAA05950@ccure.karaya.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 09, 2002  20:44 -0500, Jeff Dike wrote:
> Doesn't /dev/urandom have exactly the same DOS properties as /dev/random?
> I.e. it reads real random numbers until the entropy pool is empty, then 
> starts returning pseudo-random numbers?  If so, things on the host will 
> still hang when they then try to read /dev/random.

You are correct.  Reading from /dev/urandom consumes just as much
entropy as reading from /dev/random.  It just doesn't block when the
entropy pool is random.

Hmm, maybe this should be fixed by refilling the urandom entropy pool
much less often...

Cheers, Andreas
--
Andreas Dilger
http://www-mddsp.enel.ucalgary.ca/People/adilger/
http://sourceforge.net/projects/ext2resize/

