Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318735AbSIFPbd>; Fri, 6 Sep 2002 11:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318738AbSIFPbc>; Fri, 6 Sep 2002 11:31:32 -0400
Received: from mx5.sac.fedex.com ([199.81.194.37]:20750 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S318735AbSIFPba>; Fri, 6 Sep 2002 11:31:30 -0400
Date: Fri, 6 Sep 2002 23:35:16 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Oleg Drokin <green@namesys.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: remount reiserfs hangs under heavy load 2.4.20pre5
In-Reply-To: <20020906153029.A14514@namesys.com>
Message-ID: <Pine.LNX.4.44.0209062327150.615-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/06/2002
 11:35:59 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 09/06/2002
 11:36:05 PM,
	Serialize complete at 09/06/2002 11:36:05 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 6 Sep 2002, Oleg Drokin wrote:

> > Whenever "mount -o remount -n -w /dev/hdax" is issued under disk
> > activities, the system would freezed, and had to be hard booted.
>
> What kind of disk activies?

Activities such as compiling the kernel or rcp large files on /dev/hda3

> What was mount status of filesystems before that command was it readonly
> mounted ?

Yes, read-only on /dev/hda2, trying to change to read-write.

> I cannot reproduce this behavior with 2.4.19, can you please describe in more
> details how can we reproduce?

Using reiserfs on say /dev/hda2 200MB (/usr), mount initially as
read-only, another reiserfs /dev/hda3 800MB (/usr/src), mounted as
read-write, start compiling linux on /usr/src/linux, let it run for about
5 to 10 minutes, switch to another xterm and remount /usr as read-write
... then it may hang sometimes only. My PC is P3 1.13GHz, 650MB Ram, 30GB
hard disk. If the system is not heavily loaded enough, start rcp/cp large
amount of data from one partition to another or to another remote machine,
and remount /usr as read-only and it may hang.

Thanks,
Jeff.

