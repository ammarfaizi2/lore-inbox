Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292085AbSBYSkB>; Mon, 25 Feb 2002 13:40:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292144AbSBYSjw>; Mon, 25 Feb 2002 13:39:52 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:55027
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292085AbSBYSjl>; Mon, 25 Feb 2002 13:39:41 -0500
Date: Mon, 25 Feb 2002 10:40:21 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Dan Maas <dmaas@dcine.com>, "Rose, Billy" <wrose@loislaw.com>,
        linux-kernel@vger.kernel.org
Subject: Re: ext3 and undeletion
Message-ID: <20020225184021.GA27211@matchmail.com>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Dan Maas <dmaas@dcine.com>, "Rose, Billy" <wrose@loislaw.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <05cb01c1be1e$c490ba00$1a01a8c0@allyourbase> <Pine.LNX.3.95.1020225125900.26412A-100000@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.3.95.1020225125900.26412A-100000@chaos.analogic.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 01:08:23PM -0500, Richard B. Johnson wrote:
> On Mon, 25 Feb 2002, Dan Maas wrote:
> 
> > > but I don't want a Netware filesystem running on Linux, I
> > > want a *native* Linux filesystem (i.e. ext3) that has the
> > > ability to queue deleted files should I configure it to.
> > 
> > Rather than implementing this in the filesystem itself, I'd first try
> > writing a libc shim that overrides unlink(). You could copy files to safety,
> > or do anything else you want, before they actually get deleted...
> > 
> > Regards,
> > Dan
> > 
> Yes... unlink() becomes `mv /path/filename /deleted/path/filename`
> Simple.  For idiot users, you can just make such an alias for those

It would be nice if there was a 'deleted' dir per mount point, as that would
keep similar speeds as rm.  Also, 'deleted' would probably have to be marked
writable, but not readable and would need a suid binary to read that dir and
limit the output to only list files owned by the calling uid.  But that's a
bit too offtopic for this list...

Mike
