Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131934AbRAJKt2>; Wed, 10 Jan 2001 05:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131556AbRAJKtS>; Wed, 10 Jan 2001 05:49:18 -0500
Received: from pcep-jamie.cern.ch ([137.138.38.126]:8206 "EHLO
	pcep-jamie.cern.ch") by vger.kernel.org with ESMTP
	id <S130348AbRAJKtK>; Wed, 10 Jan 2001 05:49:10 -0500
Date: Wed, 10 Jan 2001 11:48:25 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Daniel Phillips <phillips@innominate.de>
Cc: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>,
        linux-kernel@vger.kernel.org
Subject: Re: FS callback routines
Message-ID: <20010110114825.D30055@pcep-jamie.cern.ch>
In-Reply-To: <200101091405.IAA24807@tomcat.admin.navo.hpc.mil> <3A5B3114.FAC64E04@innominate.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A5B3114.FAC64E04@innominate.de>; from phillips@innominate.de on Tue, Jan 09, 2001 at 04:41:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> > It would also be very nice if the security of the feature could be
> > confirmed. The problem with SGI's implementation is that it becomes
> > possible to monitor files that you don't own, don't have access to,
> > or are not permitted to know even exist.
> 
> To receive notification about events in a given directory you have to be
> able to open it.  Is this adequate for your needs?

No, because to open a directory you only nead read permission, whereas
to read attributes of files in the directory, you need execute
permission on the directory.

Also, you are getting notifications for unlinked files, which perhaps
you should not be able to know anything about.  (If the directory wasn't
accessible when the file was unlinked for example, but was made
accessible later).

-- Jamie
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
