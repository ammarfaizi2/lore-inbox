Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282815AbRK0GZt>; Tue, 27 Nov 2001 01:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282816AbRK0GZk>; Tue, 27 Nov 2001 01:25:40 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:27901 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S282815AbRK0GZ0>;
	Tue, 27 Nov 2001 01:25:26 -0500
Date: Mon, 26 Nov 2001 23:25:15 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] proc-based cpu affinity user interface
Message-ID: <20011126232515.V730@lynx.no>
Mail-Followup-To: Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <1006831902.842.0.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <1006831902.842.0.camel@phantasy>; from rml@tech9.net on Mon, Nov 26, 2001 at 10:31:41PM -0500
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 26, 2001  22:31 -0500, Robert Love wrote:
> Reading and writing /proc/<pid>/affinity will get and set the affinity.
> 
> Security is implemented: the writer must possess CAP_SYS_NICE or be the
> same uid as the task in question.  Anyone can read the data.

Hmm, now that I think about it, anyone should be able to restrict the
CPUs that their processes should run on, but like "nice", you should
have CAP_SYS_NICE in order to increase the number of CPUs your process
can run on.  This makes it possible to "throttle" a user so that they
can only max out a single CPU.

Why would you do that?  Maybe because "ulimit" and friends only allow
you to set an absolute limit on the number of CPU seconds you can use
per process, but not a "percentage" of a processor or some equivalent
"cycles per second" unit.

Not that I see this as being hugely necessary, but it may as well be
consistent with current behaviour (c.f. nice, ulimit, etc, can all go
down, but not necessarily up).

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

