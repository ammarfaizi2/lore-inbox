Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263926AbTIBV6c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 17:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263923AbTIBV6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 17:58:31 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:8723
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263926AbTIBV60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 17:58:26 -0400
Date: Tue, 2 Sep 2003 14:58:39 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: mutt segfault with ext3 & 1k blocks & htree in 2.6
Message-ID: <20030902215839.GC13684@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030830235819.GD898@matchmail.com> <20030831164448.O15623@schatzie.adilger.int> <20030901202729.GB31760@matchmail.com> <20030902100927.T15623@schatzie.adilger.int>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902100927.T15623@schatzie.adilger.int>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 02, 2003 at 10:09:27AM -0600, Andreas Dilger wrote:
> Normally an application segfault is really caused by a kernel OOPS, so if
> you look into your syslog file or dmesg output you should see an oops.
> 

No, I'm not seeing any oopses on this machine at all right now (not that I
couldn't cause a couple at will, but those are reported with varying degrees
of success on getting fixes)

> > And now mutt is segfaulting on non-htree directories too.
> 
> I couldn't comment on that, but either the directories are somehow corrupted
> (e2fsck will know), or the problem is related either to 1kB blocks or not
> related to the filesystem at all.

Ok, I will convert my ext3 (cp twice) to 4k blocks, and try to reproduce.
Hopefully I didn't hit a library update (in debian a mixed debian testing
/ unstable system) that caused this problem.
