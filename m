Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280895AbRKTEPA>; Mon, 19 Nov 2001 23:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280894AbRKTEOv>; Mon, 19 Nov 2001 23:14:51 -0500
Received: from h24-77-26-115.gv.shawcable.net ([24.77.26.115]:41626 "EHLO
	localhost") by vger.kernel.org with ESMTP id <S280895AbRKTEOg>;
	Mon, 19 Nov 2001 23:14:36 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ryan Cumming <bodnar42@phalynx.dhs.org>
To: Mike Castle <dalgoda@ix.netcom.com>
Subject: Re: Kernel 2.4.15-pre6 / EXT3 / ls shows '.journal' on root-fs.
Date: Mon, 19 Nov 2001 20:14:21 -0800
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33L.0111192340500.4079-100000@imladris.surriel.com> <E1661rR-0001Vl-00@localhost> <20011119200503.B10322@thune.mrc-home.com>
In-Reply-To: <20011119200503.B10322@thune.mrc-home.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E1662Ih-0001ai-00@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On November 19, 2001 20:05, Mike Castle wrote:
> On Mon, Nov 19, 2001 at 07:46:13PM -0800, Ryan Cumming wrote:
> > On November 19, 2001 19:43, you wrote:
> > > What are unintented consequences for not removing it?
> > >
> > > I.e., backups.
> >
> > It already has the "Don't back me up" attribute set ('d'), and I've come
> > across absolutely no problems running my system with it lurking in my
> > root directory.
>
> Which, as I understand it, only applies to dump for ext2fs.
Yes, you're absolutely right. Backup tools may attempt to backup the 
.journal, which is fine, because it's safely readable, and usually not large 
enough to take up significant space on the backup media. And then on restore, 
the backup tool would hit hard against .journal's immutable flag, and 
probably end up complaining loudly and skipping the file. Seems harmless 
enough. Of course, tools such as tar accept a list of files to exclude, if 
you're worried about the space wastage.

-Ryan.
