Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261326AbUDWUVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261326AbUDWUVg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 16:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbUDWUVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 16:21:36 -0400
Received: from email-out2.iomega.com ([147.178.1.83]:248 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S261340AbUDWUVd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 16:21:33 -0400
Subject: Re: Unable to read UDF fs on a DVD
From: Pat LaVarre <p.lavarre@ieee.org>
To: kronos@kronoz.cjb.net
Cc: linux_udf@hpesjro.fc.hp.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040423195004.GA1885@dreamland.darkstar.lan>
References: <20040423162801.GA5396@dreamland.darkstar.lan><1082743002.3099. 
	23.camel@patibmrh9><20040423195004.GA1885@dreamland.darkstar.lan>
Content-Type: text/plain
Organization: 
Message-Id: <1082751675.3163.106.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Apr 2004 14:21:15 -0600
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Apr 2004 20:21:32.0100 (UTC) FILETIME=[911EB040:01
	C42970]
X-imss-version: 2.0
X-imss-result: Passed
X-imss-scores: Clean:16.79060 C:49 M:1 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> http://web.tiscali.it/kronoz/ucf_test.log
> I don't see anything strange.

I now agree, that disc passed fsck and mount well enough to make the ls
failure interesting.

What to try next after fsck passes, I do not know, ouch, sorry.

Offline I'm working to comment the fs/udf/ source.  Even me finishing
that might not do you much good, unless we can figure out how to
reproduce your trouble at my desk.

Pat LaVarre

P.S. Five postscripts:

1)

> even with ide-scsi, though.

Whoa.  You weren't engaging in the taboo act of running ide-scsi in 2.6
back when ls failed, were you?  (If you are, then please remove
ide-scsi, substitute ide-cd, and confirm or deny that exercise actually
made no difference.)

2)

The disc didn't actually pass the phgfsck without complaint:  The
standard phgfsck egrep is:

$ egrep -i '(info|warning|error):' http://web.tiscali.it/kronoz/ucf_test.log
        PVD  72  Warning: Volume Set Identifier: "040420_0906",
        PVD  72  Warning: Volume Set Identifier: "040420_0906",
        Error: Number of AVDPs less than 2: 1, AVDP at 256
$

Non-compliance!

All the same, I'm guessing these complaints do Not explain the ls
failure, since to my newbie ear these sound like mount issues and we
know you can mount.

3)

I can't now rapidly reproduce the collection of file lengths you report,
because sparse files in UDF, even when the underlying volume is not
sparse, as yet crash my Linux-2.6.5.

3)

> Btw, don't know if it's related but I was unable to run ucf_test without
> scsi emulation: it complained about unknown image chunk size. I can't
> read files even with ide-scsi, though.

Yes phgfsck trouble like that is normal, thanks for asking.

4)

> > P.S. The subscriber-only archives of linux_udf@h... currently show
> > Linux-2.6.5 issues now under discussion, including an issue people have
> > reproduced by downloading a huge trial .exe into Windows and then
> > copying a file of more than 2 GiB to the disc.
> 
> I think that this is a different issue, files on my disk are smaller.

I agree your conclusion is reasonable, I do not myself yet know the
udf.ko code well enough to firmly confirm or deny your conclusion.

5)

> http://web.tiscali.it/kronoz/ucf_test.log

Any chance this link will still work, a year from now?  (I ask because
I'm hoping to see a collection of observed UDF non-compliance come into
being.)


