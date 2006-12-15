Return-Path: <linux-kernel-owner+w=401wt.eu-S965098AbWLOFCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965098AbWLOFCA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 00:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWLOFB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 00:01:59 -0500
Received: from [213.184.169.238] ([213.184.169.238]:32844 "EHLO
	localhost.localdomain" rhost-flags-FAIL-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S965098AbWLOFB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 00:01:59 -0500
X-Greylist: delayed 151876 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 00:01:56 EST
From: Al Boldi <a1426z@gawab.com>
To: Nikolai Joukov <kolya@cs.sunysb.edu>
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
Date: Fri, 15 Dec 2006 08:02:55 +0300
User-Agent: KMail/1.5
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org
References: <Pine.GSO.4.53.0612122217360.22195@compserv1> <200612132257.24399.a1426z@gawab.com> <Pine.GSO.4.53.0612141538410.6095@compserv1>
In-Reply-To: <Pine.GSO.4.53.0612141538410.6095@compserv1>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200612150802.55396.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nikolai Joukov wrote:
> > Nikolai Joukov wrote:
> > > We have designed a new stackable file system that we called RAIF:
> > > Redundant Array of Independent Filesystems.
> >
> > Great!
> >
> > > We have performed some benchmarking on a 3GHz PC with 2GB of RAM and
> > > U320 SCSI disks.  Compared to the Linux RAID driver, RAIF has
> > > overheads of about 20-25% under the Postmark v1.5 benchmark in case of
> > > striping and replication.  In case of RAID4 and RAID5-like
> > > configurations, RAIF performed about two times *better* than software
> > > RAID and even better than an Adaptec 2120S RAID5 controller.
> >
> > I am not surprised.  RAID 4/5/6 performance is highly sensitive to the
> > underlying hw, and thus needs a fair amount of fine tuning.
>
> Nevertheless, performance is not the biggest advantage of RAIF.  For
> read-biased workloads RAID is always slightly faster than RAIF.  The
> biggest advantages of RAIF are flexible configurations (e.g., can combine
> NFS and local file systems), per-file-type storage policies, and the fact
> that files are stored as files on the lower file systems (which is
> convenient).

Ok, a I was just about to inform you of a three nfs-branch raif which was 
unable to fill the net pipe.  So it looks like a 25% performance hit across 
the board.  Should be possible to reduce to sub 3% though once RAIF matures, 
don't you think?


> > > This is because RAIF is located above
> > > file system caches and can cache parity as normal data when needed. 
> > > We have more performance details in a technical report, if anyone is
> > > interested.
> >
> > Definitely interested.  Can you give a link?
>
> The main focus of the paper is on a general OS profiling method and not
> on RAIF.  However, it has some details about the RAIF benchmarking with
> Postmark in Chapter 9:
>
>   <http://www.fsl.cs.sunysb.edu/docs/joukov-phdthesis/thesis.pdf>
>
> Figures 9.7 and 9.8 also show profiles of the Linux RAID5 and RAIF5
> operation under the same Postmark workload.


Thanks!

--
Al

