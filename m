Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264968AbTLFInK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 03:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264971AbTLFInK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 03:43:10 -0500
Received: from ookhoi.xs4all.nl ([213.84.114.66]:54181 "EHLO
	favonius.humilis.net") by vger.kernel.org with ESMTP
	id S264968AbTLFInH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 03:43:07 -0500
Date: Sat, 6 Dec 2003 09:43:05 +0100
From: Ookhoi <ookhoi@humilis.net>
To: Daniel Flinkmann <dflinkmann@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Corrupt files with kernel 2.6.0_test11 and smb mounts
Message-ID: <20031206084305.GB22180@favonius>
Reply-To: ookhoi@humilis.net
References: <013301c3b801$6c595de0$7727048b@de.uu.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <013301c3b801$6c595de0$7727048b@de.uu.net>
X-Uptime: 17:58:39 up 15 days,  9:22, 25 users,  load average: 1.02, 1.01, 1.00
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Flinkmann wrote (ao):
> > [1.] One line summary of the problem:
> >
> > 2.6.0test11 overwriting file on mounted smb volume causes corrupted files!
> >
> > [2.] Full description of the problem/report:
> >
> > When I log into a smb mounted directory and I overwrite a file with
> > a file which has smaller amount of bytes its corrupting the data.
> >
> > Easy way to show this is following:
> >
> > cd onto a smbfs mounted dir.
> >
> > ># echo test1234567890 >test.txt
> > ># cat test.txt
> > test1234567890
> > ># echo hi! >test.txt
> > ># cat test.txt
> > hi!
> > 1234567890
> > >#
> >
> > As you can see the file is not overwritten as it should be.
> 
> Ookhoi reported the same Problem with 2.6.0_test9 in the Samba Group:
> http://lists.samba.org/archive/samba-technical/2003-November/032847.html

That should be:
http://lists.samba.org/archive/samba-technical/2003-November/032845.html

> This could also be a Memorymanagement problem because the filesystem is
> always breaking the last block, which is handled different to the other
> blocks.

Could this be the answer to the problem?
http://www.ussg.iu.edu/hypermail/linux/kernel/0312.0/0647.html

I don't have access to the setup anymore, but maybe it helps you.
