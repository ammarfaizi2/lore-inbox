Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273382AbRIRLIl>; Tue, 18 Sep 2001 07:08:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273390AbRIRLIg>; Tue, 18 Sep 2001 07:08:36 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:14859 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S273382AbRIRLIX>; Tue, 18 Sep 2001 07:08:23 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Mike Fedyk <mfedyk@matchmail.com>
Date: Tue, 18 Sep 2001 21:08:32 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15271.11056.810538.66237@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Define conflict between ext3 and raid patches against 2.2.19
In-Reply-To: message from Mike Fedyk on Sunday September 16
In-Reply-To: <20010916155835.C24067@mikef-linux.matchmail.com>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday September 16, mfedyk@matchmail.com wrote:
> Hi,
> 
> I'm trying to setup a 2.2 kernel that I can use for comparison to the latest
> 2.4 kernels I've been testing, but I came accross a little problem with the
> patches I've been trying to combine.
> 
> I've already applied:
> ide.2.2.19.05042001.patch
> linux-2.2.19.kdb.diff
> linux-2.2.19.ext3.diff
> 
> And now I'm trying to apply raid-2.2.19-A1, and I get one reject in
> include/linux/fs.h.

You should be aware that ext3 (and other journalling filesystems) do
not work reliably over RAID1 or RAID5 in 2.2.  Inparticular, you can
get problems when the array is rebuilding/resyncing.

But if you only plan to use ext3 with raid0 or linear, you should be
fine.

NeilBrown
