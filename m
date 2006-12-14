Return-Path: <linux-kernel-owner+w=401wt.eu-S932937AbWLNVf1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932937AbWLNVf1 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 16:35:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932941AbWLNVf1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 16:35:27 -0500
Received: from smtp.firstline.co.nz ([203.167.210.162]:4058 "HELO
	firstline.co.nz" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932936AbWLNVfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 16:35:25 -0500
From: Charles Manning <manningc2@actrix.gen.nz>
To: Nikolai Joukov <kolya@cs.sunysb.edu>
Subject: Re: [ANNOUNCE] RAIF: Redundant Array of Independent Filesystems
Date: Fri, 15 Dec 2006 10:30:31 +1300
User-Agent: KMail/1.8
Cc: Al Boldi <a1426z@gawab.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
References: <Pine.GSO.4.53.0612122217360.22195@compserv1> <200612132257.24399.a1426z@gawab.com> <Pine.GSO.4.53.0612141538410.6095@compserv1>
In-Reply-To: <Pine.GSO.4.53.0612141538410.6095@compserv1>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612151030.31846.manningc2@actrix.gen.nz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 15 December 2006 10:01, Nikolai Joukov wrote:
> > Nikolai Joukov wrote:
> > > We have designed a new stackable file system that we called RAIF:
> > > Redundant Array of Independent Filesystems.
> >
> > Great!

Yes, definitely...

I see the major benefit being in the mobile, industrial and embedded systems 
arena. Perhaps this might come as a suprise to people, but a very large and 
ever growing number (perhaps even most) Linux devices don't use block devices 
for storage. Instead they use flash file systems or nfs, niether of which use 
local block devices.

It looks like RAIF gives a way to provide redundancy etc on these devices.


> >
> > > We have performed some benchmarking on a 3GHz PC with 2GB of RAM and
> > > U320 SCSI disks.  Compared to the Linux RAID driver, RAIF has overheads
> > > of about 20-25% under the Postmark v1.5 benchmark in case of striping
> > > and replication.  In case of RAID4 and RAID5-like configurations, RAIF
> > > performed about two times *better* than software RAID and even better
> > > than an Adaptec 2120S RAID5 controller.
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
>
> > > This is because RAIF is located above
> > > file system caches and can cache parity as normal data when needed.  We
> > > have more performance details in a technical report, if anyone is
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
>
> Nikolai.
> ---------------------
> Nikolai Joukov, Ph.D.
> Filesystems and Storage Laboratory
> Stony Brook University
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
