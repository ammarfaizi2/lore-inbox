Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275767AbRI1Hde>; Fri, 28 Sep 2001 03:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275861AbRI1HdZ>; Fri, 28 Sep 2001 03:33:25 -0400
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:25334 "EHLO
	webber.adilger.int") by vger.kernel.org with ESMTP
	id <S275767AbRI1HdO>; Fri, 28 Sep 2001 03:33:14 -0400
From: Andreas Dilger <adilger@turbolabs.com>
Date: Fri, 28 Sep 2001 01:33:03 -0600
To: Bobby Hitt <bobhitt@bscnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2GB File limitation
Message-ID: <20010928013303.A597@turbolinux.com>
Mail-Followup-To: Bobby Hitt <bobhitt@bscnet.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <013801c147e5$3330bec0$092cdb3f@bobathome>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013801c147e5$3330bec0$092cdb3f@bobathome>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 28, 2001  02:17 -0400, Bobby Hitt wrote:
> Is someone working on a way to overcome the 2GB file limitation in Linux? I
> currently backup several servers using a dedicated hard drive for the
> backups. Recently I saw one backup die saying the the file size had been
> exceeded.

This is your lucky day.  The 2GB limit has been fixed a year or two ago.
You need an "LFS" patch for 2.2 kernels (any vendor kernel will have this),
or any 2.4 kernel.

You ALSO need to ensure your libc supports large files (glibc-2.2
definitely will), and also that your tools can handle it (needs to be
compiled with special LARGEFILE defines, and open files with O_LARGEFILE).

Cheers, Andreas
--
Andreas Dilger  \ "If a man ate a pound of pasta and a pound of antipasto,
                 \  would they cancel out, leaving him still hungry?"
http://www-mddsp.enel.ucalgary.ca/People/adilger/               -- Dogbert

