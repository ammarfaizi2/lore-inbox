Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274610AbRIYKkT>; Tue, 25 Sep 2001 06:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274611AbRIYKkK>; Tue, 25 Sep 2001 06:40:10 -0400
Received: from femail35.sdc1.sfba.home.com ([24.254.60.25]:32684 "EHLO
	femail35.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274610AbRIYKj4>; Tue, 25 Sep 2001 06:39:56 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: "Dr. Michael Weller" <eowmob@exp-math.uni-essen.de>,
        "[A]ndy80" <andy80@ptlug.org>
Subject: Re: Burning a CD image slow down my connection
Date: Tue, 25 Sep 2001 03:40:18 -0700
X-Mailer: KMail [version 1.3.1]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.A32.3.95.1010925121523.20872B-100000@werner.exp-math.uni-essen.de>
In-Reply-To: <Pine.A32.3.95.1010925121523.20872B-100000@werner.exp-math.uni-essen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010925104017.RLQT29954.femail35.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 25 September 2001 03:21 am, Dr. Michael Weller wrote:
> On 25 Sep 2001, [A]ndy80 wrote:
> > I've my Plextor Writer as secondary master seen as a scsi device
> > and if I try do use hdparm it says:
> >
> > [root@piccoli shady]# hdparm -t /dev/cdrom
> > /dev/cdrom not supported by hdparm
>
> Hmm, /dev/cdrom would typically be a link. You might try to apply
> hdparm to where the link points to, but I cannot really believe
> hdparm doesn't follow links.
>
> Normally /dev/cdrom should point to /dev/hdc in your case. I somewhat
> suspect that it points to /dev/scd0. If so, can you actually
> mount the cdrom? The ide2scsi device emulation basically just passes
> scsi commands as atapi commands over the ide bus (since atapi just
> use the scsi commands but tunnel them over ide). I'm surprised this
> also works for cdroms. I wasn't aware of the fact they are ATAPI and
> thus support the scsi command set. Maybe the cdwriters are special in
> that context.

My DVD-ROM drive and Plextor PlexWriter CD-RW drive both function under 
the idescsi emulation driver. *All* current IDE CD writers are ATAPI 
and REQUIRE idescsi (or in windows, an ASPI layer) in order to be used 
as a cd writer.
