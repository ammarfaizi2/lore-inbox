Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282900AbRK0Th3>; Tue, 27 Nov 2001 14:37:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282897AbRK0ThS>; Tue, 27 Nov 2001 14:37:18 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:16125
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S282900AbRK0ThG>; Tue, 27 Nov 2001 14:37:06 -0500
Date: Tue, 27 Nov 2001 11:37:00 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Mark Richards <richard@ecf.utoronto.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Multiplexing filesystem
Message-ID: <20011127113700.C9391@mikef-linux.matchmail.com>
Mail-Followup-To: Mark Richards <richard@ecf.utoronto.ca>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C030FB4.C3303BE4@ecf.utoronto.ca> <3C036A83.F23E6EBE@idb.hist.no> <3C03A702.EBE823C9@ecf.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C03A702.EBE823C9@ecf.utoronto.ca>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 09:45:22AM -0500, Mark Richards wrote:
> Helge Hafting wrote:
> 
> >
> > Coda already do what you want:
> > Files are kept on a server, and copied to your local disk when
> > you use it.  You may even disconnect when working on the local
> > copy - your changes will be propagated back to the server
> > whenever you reconnect to the network.
> > The copying is indeed completely transparent.
> >
> > If you need reservation - use the permission system.
> > A suid program simply makes _you_ owner, and only
> > the owner gets write permission.  This is your check-out
> > program.  Check-in consists of changing ownership
> > back to root (or some userid allocated to the versioning system)
> >
> > Helge Hafting
> 
> I'll look into Coda, but ideally I wouldn't have to copy each file to the local
> workstation when I use it, only when it is reserved for editing.  Also, I'd like to
> be able to store the local copy anywhere on the filesystem, if possible.
> 

Don't know much about coda, but...

Helge has basically said that the files *are* copied to your system
transparently (probably to a configurable location) and once you are
finished it will be synced with the coda server.

If you need *exclusive* access, just check out (change permissions to you as
owner, and chmod 0600), and back when you're done.  This is probably done
with root suid tools to be able to chown.

MF
