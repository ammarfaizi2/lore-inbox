Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264736AbUD1Kx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264736AbUD1Kx3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 06:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264735AbUD1Kx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 06:53:28 -0400
Received: from sea2-f49.sea2.hotmail.com ([207.68.165.49]:11780 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S264770AbUD1KxY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 06:53:24 -0400
X-Originating-IP: [213.26.1.130]
X-Originating-Email: [pupilla@hotmail.com]
From: "Marco Berizzi" <pupilla@hotmail.com>
To: samba@lists.samba.org
Cc: linux-kernel@vger.kernel.org
Subject: FW: Re: md5 fail on large file
Date: Wed, 28 Apr 2004 12:53:21 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea2-F49hiWnZdgHbQf0001180c@hotmail.com>
X-OriginalArrivalTime: 28 Apr 2004 10:53:21.0672 (UTC) FILETIME=[05B4F080:01C42D0F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Me again. I think I have found which is the problem.
After I have copied the file from NT4TSE to samba, I have run
df on the filesystem, and the used space was minor than the
filesize printed by ls -l

ls -l priv.edb

-rwxr--r-- 1 user group 5393883136 Apr 28 10:58 priv.edb

du priv.edb

4194364 priv.edb

df

df /dev/hda8 99396660  41994828  95201832  5% /mnt/data

My env: linux-2.4.26. /dev/hda8 is XFS, samba-3.0.2a Slack 9.1

Comments?


Marco Berizzi wrote:

>I have switched back to samba 2.2.8a (compiled
>from source) on linux 2.6.5: same behaviour.
>
>
>Marco Berizzi wrote:
>
> > Me again. I have upgraded to linux kernel
> > 2.6.5. However this problem hasn't gone away.
> > The md5 check is fine, coping the same file
> > from NT4TSE to a Windoze 2000sp4.
> > Coping the same file from a windoze 2000sp4
> > to the samba share is ok. So the problem is
> > between NT4TSE and samba.
> >
> > NT4TSE --> SAMBA = KO
> > WIN2k  --> SAMBA = OK
> > NT4TSE --> WIN2K = OK
> >
> > Can anybody help me?
>
>
> > Marco Berizzi wrote:
>
>
> > > Hello everybody.
> > >
> > > I'm experimenting this problem with
> > > samba 3.0.2a and linux 2.4.25 with
> > > ReiserFS.
> > > When I copy (put) a large file (5GB)
> > > from a Windows NT terminal server sp6a
> > > to the samba-linux box, the md5sum is
> > > different between the two file. Files
> > > size are identical.
> > > I'm using this command to copy these
> > > files from windows to samba:
> > >
> > > xcopy f:\ \\mimas\backup\exchange /e /c /h /r
> > >
> > > I have also tried to delete the old
> > > files from the samba share, but nothing
> > > change: I always get two different md5sum.
> > > With smaller files (400MB) md5sum is
> > > identical.
> > > When I transfer this large file with ftp
> > > (proftpd 1.2.9 on Linux), md5sum is ok.
> > >
> > > These two systems are connected to a 3COM
> > > 100bit/s switch. No collision/no error are
> > > detected at linux side box. Samba doesn't
> > > log anything relevant. No kernel error.
> > > Nothing. Samba box is running Slackware 9.1
> > > + kernel 2.4.25 + samba 3.0.2a compiled
> > > from sources.
> > >
> > > Hints?
> > >
> > > PS: Please CC me I'm not subscribed to this list.

_________________________________________________________________
Protect your PC - get McAfee.com VirusScan Online 
http://clinic.mcafee.com/clinic/ibuy/campaign.asp?cid=3963

