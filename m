Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030604AbVKXFPf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030604AbVKXFPf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:15:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030605AbVKXFPf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:15:35 -0500
Received: from bee.hiwaay.net ([216.180.54.11]:35357 "EHLO bee.hiwaay.net")
	by vger.kernel.org with ESMTP id S1030604AbVKXFPe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:15:34 -0500
Date: Wed, 23 Nov 2005 23:15:28 -0600
From: Chris Adams <cmadams@hiwaay.net>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Generation numbers in stat was Re: what is slashdot's answer to ZFS?
Message-ID: <20051124051528.GB1121157@hiwaay.net>
References: <fa.d8ojg69.1p5ovbb@ifi.uio.no> <20051122161712.GA942598@hiwaay.net> <1132690779.20233.74.camel@localhost.localdomain> <20051122195652.GB660478@hiwaay.net> <p731x17jhmk.fsf_-_@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p731x17jhmk.fsf_-_@verdi.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Once upon a time, Andi Kleen <ak@suse.de> said:
> Chris Adams <cmadams@hiwaay.net> writes:
> >   [Tru64 UNIX]  However, in the rare case when a user application has been
> >   deleting open files, and a file serial number is reused, a third structure
> >   member in <sys/stat.h>, the file generation number, is needed to uniquely
> >   identify a file. This member, st_gen, is used in addition to st_ino and
> >   st_dev.
> 
> Sounds like a cool idea. Many fs already maintain this information
> in the kernel. We still had some unused pad space in the struct stat
> so it could be implemented without any compatibility issues 
> (e.g. in place of __pad0). On old kernels it would be always 0.

Searching around some, I see that OS X has st_gen, but the man page I
found says it is only available for super-user.  It also appears that
AIX and at least some of the BSDs have it (which would make sense I
guess as Tru64, OS X, and IIRC AIX are all BSD derived).

Also, I ses someone pitched it to linux-kernel several years ago but it
didn't appear to go anywhere.  Maybe time to rethink that?
-- 
Chris Adams <cmadams@hiwaay.net>
Systems and Network Administrator - HiWAAY Internet Services
I don't speak for anybody but myself - that's enough trouble.
