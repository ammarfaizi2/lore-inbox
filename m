Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbSJCXzN>; Thu, 3 Oct 2002 19:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261513AbSJCXzM>; Thu, 3 Oct 2002 19:55:12 -0400
Received: from cynaptic.com ([128.121.116.181]:24335 "EHLO cynaptic.com")
	by vger.kernel.org with ESMTP id <S261512AbSJCXzK>;
	Thu, 3 Oct 2002 19:55:10 -0400
From: "Effrem Norwood" <enorwood@effrem.com>
To: "Kanoalani Withington" <kanoa@cfht.hawaii.edu>,
       "Roy Sigurd Karlsbakk" <roy@karlsbakk.net>
Cc: <jbradford@dial.pipex.com>, <jakob@unthought.net>,
       <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>
Subject: RE: RAID backup
Date: Thu, 3 Oct 2002 16:59:57 -0700
Message-ID: <CFEAJJEGMGECBCJFLGDBCENHCEAA.enorwood@effrem.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
In-Reply-To: <3D9CA1C7.2000405@cfht.hawaii.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have to pipe in here and agree that the idea of using a disk array
> alone for backups is not a sound idea. Sure, backing up 2Tb to an old
> exabyte drive isn't going to work, if you really have that much data you
> need some more modern equipment.

I've worked in the storage industry for years and surprisingly more and more
organizations *are* moving to disk only backup strategies with a lot of good
reasons for doing so. Large companies are replacing 100% of their tape
infrastructure with multiple large yet inexpensive disk array's. Disk backup
infrastructure prices are now equal to or lower than tape backup
infrastructure prices on initial acquisition, and significantly lower if you
factor in ROI and TCO - not to mention huge backup/restore time savings and
potential disaster recovery possibilities.

> Essentially I believe the idea of a redundant array sounds safer than it
> really is in practice, especially when dealing with very large arrays
> and with level 5 arrays. The reasons why this is so are manifold,
> suffice to say that a few years of actually using such devices shows
> that they have much more potential for catastrophic failure and latent
> failure (you don't know it's broken until you go to use it and find out
> it's broken) than a well designed tape archive or backup.

With multiple inexpensive large disk arrays from companies like Network
Appliance (NearStor) and Exstor (T-2120) organizations are asynchronously
mirroring their data to geographically distant locations to prevent single
points of failure with their arrays. As you suggest, a single array can fail
and lose data. From a tape perspective, a tape in a backup set can fail as
well-potentially presenting the same catastrophic situation of not being
able to recover. Just as organizations have multiple sets of tapes on a
rotation schedule, organizations now often have multiple large near-line
storage arrays with a data rotation schedule.

> Not that disk to disk backups are a completely bad idea. In my
> experience a combination works best. For example, automatic backups to
> reserved disks or disk arrays on remote systems every night, but once a
> week tape snapshots of that data. It's a lot of tapes but over time it
> will prove to be worthwhile. If the data volume is too high, simple
> backup scripts that write every file only once (essentially an archive)
> to tape to make it more practical.

Classical Hierarchical Storage Management (HSM) as you describe here is
being undermined by the fact that these large IDE based disk arrays are
equally or less expensive than tapes. In addition, HSM software costs
something (even if you write it yourself) on top of the tape infrastructure.
One customer of ours was quoted 40K per TB of HSM *software* alone. Well
designed tape replacement disk systems can cost 25K per TB or less and have
many advantages over tape. Online data, faster data access, and disaster
recovery just to name a few. Further, backup software vendors like Veritas
and Legato now recognize disks as a viable tape replacement and are
incorporating that fact into their software.

If tape is absolutely required, the infrastructure required per TB of taped
data can be significantly smaller and the backup window can be massively
extended - from hours to weeks with a large near-line disk approach. The
tape/library cost component in this way is significantly reduced.

For purposes of full disclosure, I work at Exstor and we provide tape
replacement solutions as well as high performance NAS solutions for the
enterprise.

Regards,

Eff Norwood


