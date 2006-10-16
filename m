Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbWJPGUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbWJPGUx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 02:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbWJPGUx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 02:20:53 -0400
Received: from herkules.vianova.fi ([194.100.28.129]:35777 "HELO
	mail.vianova.fi") by vger.kernel.org with SMTP id S1030306AbWJPGUw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 02:20:52 -0400
Date: Mon, 16 Oct 2006 09:20:49 +0300
From: Ville Herva <vherva@vianova.fi>
To: Andries Brouwer <Andries.Brouwer@cwi.nl>
Cc: Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Why aren't partitions limited to fit within the device?
Message-ID: <20061016062049.GE23144@vianova.fi>
Reply-To: vherva@vianova.fi
References: <17710.54489.486265.487078@cse.unsw.edu.au> <20061015082921.GC22674@vianova.fi> <17714.51511.845336.721450@cse.unsw.edu.au> <20061016060227.GA3090@apps.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061016060227.GA3090@apps.cwi.nl>
X-Operating-System: Linux herkules.vianova.fi 2.4.32-rc1
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 08:02:27AM +0200, you [Andries Brouwer] wrote:
> On Mon, Oct 16, 2006 at 09:50:15AM +1000, Neil Brown wrote:
> > On Sunday October 15, vherva@vianova.fi wrote:
> 
> > > I wonder if there's ever a change the kernel partition detection code could
> > > _write_ on the disk, even when there's really no partition table?
> > 
> > No, kernel partition detection never writes.
> 
> There is something else that writes, however, that I have gotten complaints about.
> (But I have not investigated.)
> People doing forensics take a copy of a disk and want to preserve
> that copy as-is, never changing a single bit, only looking at it.
> But it is reported that also when a partition is mounted read-only,
> the journaling code of ext3 will write to the journal.

Yes, that's (sort of) known. As in "mentioned on lkml" - perhaps even in
some documentation.

In this case, the fs was ext2, though, and the problem occurred even when
the fs was never mounted and the raid device was never started.



-- v -- 

v@iki.fi

