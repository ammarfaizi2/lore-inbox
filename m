Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285449AbRLNSKs>; Fri, 14 Dec 2001 13:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285448AbRLNSK3>; Fri, 14 Dec 2001 13:10:29 -0500
Received: from adsl-216-102-214-42.dsl.snfc21.pacbell.net ([216.102.214.42]:28420
	"HELO marcus.pants.nu") by vger.kernel.org with SMTP
	id <S285440AbRLNSK1>; Fri, 14 Dec 2001 13:10:27 -0500
Subject: Re: reiser4 (was Re: [PATCH] Revised extended attributes  interface)
To: reiser@namesys.com (Hans Reiser)
Date: Fri, 14 Dec 2001 10:27:14 -0800 (PST)
Cc: andrew@pimlott.ne.mediaone.net (Andrew Pimlott),
        aia21@cam.ac.uk (Anton Altaparmakov), nathans@sgi.com (Nathan Scott),
        ag@bestbits.at (Andreas Gruenbacher), linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-xfs@oss.sgi.com
In-Reply-To: <3C19DE41.6000507@namesys.com> from "Hans Reiser" at Dec 14, 2001 02:10:57 PM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20011214182715.08C352B54A@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:
> Brad Boyer wrote:
> >Yes, these things can be survived, but speaking as someone who currently
> >has a job involving multiple NetApp boxes, I can say that the .snapshot
> >directory has some seriously annoying properties that break tar and
> >other programs that expect things to look normal. The snapshots have
> >saved my ass a few times, but they're still a pain to work with due
> >to a few little quirks. In particular, the files in the snapshot keep
> >the same inode number as the actual file. Just remember that clever
> >solutions that almost fit the traditional model can have strange
> >results over time.
> 
> Can you detail the problem?
> 

The problem with the NetApp snapshots is that tar and cp and a few other
programs that check inode numbers get confused and think everything in
the snapshot is a hard link. So you can't copy a snapshot of a file back
over the original without copying it somewhere else first, and it's
painful to make an archive of the snapshots. We have data files on our
filers that get updated frequently, and any time I need to analyze the
same file over time, or restore an old file, it causes problems. I was
throwing it out more as an example of what sort of unexpected things
happen when you slightly change the way the filesystem works.

	Brad Boyer
	flar@allandria.com

