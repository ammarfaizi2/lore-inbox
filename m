Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263603AbUCUJJh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Mar 2004 04:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263622AbUCUJJg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Mar 2004 04:09:36 -0500
Received: from colo.khms.westfalen.de ([213.239.196.208]:53458 "EHLO
	colo.khms.westfalen.de") by vger.kernel.org with ESMTP
	id S263603AbUCUJJf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Mar 2004 04:09:35 -0500
Date: 21 Mar 2004 10:00:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <95IkrqqXw-B@khms.westfalen.de>
In-Reply-To: <405C2AC0.70605@stesmi.com>
Subject: Re: finding out the value of HZ from userspace
X-Mailer: CrossPoint v3.12d.kh13 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <20040311141703.GE3053@luna.mooo.com> <40578FDB.9060000@aurema.com> <20040320102241.GK2803@devserv.devel.redhat.com> <20040320102241.GK2803@devserv.devel.redhat.com> <405C2AC0.70605@stesmi.com>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stesmi@stesmi.com (Stefan Smietanowski)  wrote on 20.03.04 in <405C2AC0.70605@stesmi.com>:

> >>>there is one. Nothing uses it
> >>>(sysconf() provides this info)
> >>
> >>Seems to me that it would be fairly trivial to modify those programs
> >>(that should use this mechanism but don't) to use it?  So why should
> >>they be allowed to dictate kernel behaviour?
> >
> >
> > quality of implementation; for example shell scripts that want to do
> > echo 500 > /proc/sys/foo/bar/something_in_HZ
> > ...
> > or /etc/sysctl.conf or ...
> >
>
> Then write a simple program already. How hard is it to write a program
> that does a sysconf() and returns (as ascii of course) just the
> value of HZ? Then do some trivial calculation off of that.

How about a slightly more useful utility, like this:

$ getconf CLK_TCK
100
$ getconf OPEN_MAX
1024
$ getconf PATH_MAX /proc/
4096
$

MfG Kai
