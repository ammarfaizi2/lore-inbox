Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbTHZUST (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 16:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbTHZUST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 16:18:19 -0400
Received: from mailwasher.lanl.gov ([192.16.0.25]:26971 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S262619AbTHZUSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 16:18:17 -0400
Subject: Re: reiser4 snapshot for August 26th.
From: Steven Cole <elenstev@mesatop.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: Oleg Drokin <green@namesys.com>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>,
       Alex Zarochentsev <zam@namesys.com>, reiserfs-dev@namesys.com,
       reiserfs-list@namesys.com, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20030826200530.GC1258@matchmail.com>
References: <20030826102233.GA14647@namesys.com>
	 <1061922037.1670.3.camel@spc9.esa.lanl.gov>
	 <20030826182609.GO5448@backtop.namesys.com>
	 <1061926566.1076.2.camel@teapot.felipe-alfaro.com>
	 <20030826194321.GA25730@namesys.com>
	 <1061927482.1666.36.camel@spc9.esa.lanl.gov>
	 <20030826200530.GC1258@matchmail.com>
Content-Type: text/plain
Organization: 
Message-Id: <1061928831.1666.46.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 26 Aug 2003 14:13:51 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-26 at 14:05, Mike Fedyk wrote:
> On Tue, Aug 26, 2003 at 01:51:22PM -0600, Steven Cole wrote:
> > I did a "time bk -r co" for the current 2.6 tree, and here
> > are the results for reiser4 and ext3 on 2.6.0-test4:
> > 
> > Reiser4:
> > real    1m55.077s
> > user    0m30.740s
> > sys     0m36.558s
> > 
> > Ext3:
> > real    3m48.438s
> > user    0m26.400s
> > sys     0m13.205s
> > 
> 
> Can you try ext3 with -o data=writeback, as well as xfs & reiser3?

[root@spc1 /]# umount /dev/hda9
[root@spc1 /]# mount -t ext3 -o data=writeback /dev/hda9 /home
[root@spc1 /]# mount -t reiserfs /dev/hda10 /share_r
[root@spc1 /]# mount -t xfs /dev/hda12 /share_x

[root@spc1 /]# df -T
Filesystem    Type   1K-blocks      Used Available Use% Mounted on
/dev/hda1     ext3      241116     89449    139219  40% /
none         tmpfs      126784         0    126784   0% /dev/shm
/dev/hda8     ext3      241116      4711    223957   3% /tmp
/dev/hda6     ext3     3012204   2507596    351592  88% /usr
/dev/hda7     ext3      489992     70724    393968  16% /var
df: `/share_r4': Value too large for defined data type
/dev/hda9     ext3    20556656  16526268   4030388  81% /home
/dev/hda10
          reiserfs     4112476   1911220   2201256  47% /share_r
/dev/hda12     xfs     4991380    990884   4000496  20% /share_x

Yes, I can do that.  Results in a little while.

BTW, this is RedHat Severn, so df --version gives
[steven@spc1 /]$ df --version
df (coreutils) 5.0

Steven


