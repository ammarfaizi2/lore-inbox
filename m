Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131809AbRDPSAg>; Mon, 16 Apr 2001 14:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131832AbRDPSA1>; Mon, 16 Apr 2001 14:00:27 -0400
Received: from mailout04.sul.t-online.com ([194.25.134.18]:41739 "EHLO
	mailout04.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S131820AbRDPSAX>; Mon, 16 Apr 2001 14:00:23 -0400
Date: 16 Apr 2001 17:37:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: viro@math.psu.edu
cc: linux-kernel@vger.kernel.org
Message-ID: <7zziWk4Xw-B@khms.westfalen.de>
In-Reply-To: <Pine.GSO.4.21.0103120835390.25792-100000@weyl.math.psu.edu>
Subject: Re: Should mount --bind not follow symlinks?
X-Mailer: CrossPoint v3.12d.kh5 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <Pine.GSO.4.21.0103120835390.25792-100000@weyl.math.psu.edu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

viro@math.psu.edu (Alexander Viro)  wrote on 12.03.01 in <Pine.GSO.4.21.0103120835390.25792-100000@weyl.math.psu.edu>:

> On Mon, 12 Mar 2001, Anthony Heading wrote:
>
> > Hi,
> >     My automounted dirs have up till now been symlinks, where
> > e.g. /opt/perl defaults to automounting /export/opt/perl/LATEST
> > which is a symlink.
> >
> >    This all worked OK until the 2.4(.2) automounter helpfully tries
> > to mount --bind /export/opt/perl/LATEST /opt/perl
>
> Don't mix symlinks with mounts/bindings. Too much PITA and yes, it had
> been deliberately prohibited. You _really_ don't want to handle the
> broken symlinks and all the realted fun - race-ridden at extreme and
> useless.

Race? Where? You resolve the symlink once and operate on the result. No  
need to remember anywhere that it ever was a symlink. If there *can* be a  
race, this sounds like a serious design bug.

This looks like it *seriously* breaks my current 2.2 setup: I have dirs  
with sensible names under /Partition, and symlinks to those dirs whose  
name is the UUID for mount to use. Nothing automount in here. (And of  
course all those links and directories are completely static and only root- 
modifiable anyway, this only changes when I repartition.)

MfG Kai
