Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161318AbWALVnh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161318AbWALVnh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:43:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161323AbWALVnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:43:37 -0500
Received: from smtp.osdl.org ([65.172.181.4]:63137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161321AbWALVng (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:43:36 -0500
Date: Thu, 12 Jan 2006 13:42:55 -0800
From: Andrew Morton <akpm@osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org,
       "Brown, Len" <len.brown@intel.com>,
       David Woodhouse <dwmw2@infradead.org>, Jens Axboe <axboe@suse.de>,
       Steven French <sfrench@us.ibm.com>, Roland Dreier <rolandd@cisco.com>,
       Wim Van Sebroeck <wim@iguana.be>, Anton Altaparmakov <aia21@cantab.net>,
       Dominik Brodowski <linux@dominikbrodowski.net>
Subject: git status (was: drm tree for 2.6.16-rc1)
Message-Id: <20060112134255.29074831.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601121016020.3535@g5.osdl.org>
References: <Pine.LNX.4.58.0601120948270.1552@skynet>
	<Pine.LNX.4.64.0601121016020.3535@g5.osdl.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
>
> 
> 
> On Thu, 12 Jan 2006, Dave Airlie wrote:
> > 
> > Hi Linus,
> > 	Can you pull the drm-forlinus branch from
> > git://git.kernel.org/pub/scm/linux/kernel/git/airlied/drm-2.6.git
> > 
> > This is a pretty major merge over of DRM CVS, and every driver in the DRM
> > is brought up to latest versions....
> 
> I'm actually somewhat inclined to not pull any more. We've had lots of 
> (hopefully minor) issues for the last few days, and I know that people 
> had DRM issues with the -mm tree (which I assume tracked this tree) not 
> more than a week or so ago.

iirc that was AGP.  DRM had a few won't-compile problems, now fixed.

So I think we could squeeze DRM in, but yes, it's getting to that time.

> IOW, I want to make sure that my tree is somewhat stable again. I don't 
> want -rc1 to be horrible.

Merge status:

Size in bytes			tree
(including changlog)

666832				git-acpi.patch
2534				git-agpgart.patch
98909				git-audit.patch
32930				git-cfq.patch
46766				git-cifs.patch
289519				git-drm.patch
465768				git-infiniband.patch
1045				git-ntfs.patch
9244				git-ocfs2.patch
40442				git-pcmcia.patch
24191				git-sym2.patch
31765				git-watchdog.patch

acpi: A few recent reports of AML-level unaligned accesses in that tree.

audit: we're tracking one oops which seems to be coming out of the audit code

cfq: OK

CIFS: no problems of which I'm aware

DRM: no problems of which I'm aware

infiniband: Roland, you need to resend the pull request asap, please.

ntfs: no problems of which I'm aware 

ocfs2: it's a small update

pcmcia: had a problem but I think that's now fixed.  But this seems
        to be fairly fresh code?

sym2: no problems of which I'm aware

watchdog: Wim has been very quiet in recent months.  No problems
          of which I'm aware.
