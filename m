Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319550AbSIMIBR>; Fri, 13 Sep 2002 04:01:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319552AbSIMIBQ>; Fri, 13 Sep 2002 04:01:16 -0400
Received: from urtica.linuxnews.pl ([217.67.200.130]:20750 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S319550AbSIMIBP>; Fri, 13 Sep 2002 04:01:15 -0400
Date: Fri, 13 Sep 2002 10:05:55 +0200 (CEST)
From: Pawel Kot <pkot@bezsensu.pl>
X-X-Sender: <pkot@urtica.linuxnews.pl>
To: Grega Fajdiga <Gregor.Fajdiga@telemach.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: NTFS errors
In-Reply-To: <20020913093529.517f6d14.Gregor.Fajdiga@telemach.net>
Message-ID: <Pine.LNX.4.33.0209131003100.19974-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Sep 2002, Grega Fajdiga wrote:

Hi Grega,

> I am using lk 2.4.19 + a NTFS 2.1.0 patch. Once in a while I get
> lots of these errors:
>
> Sep 10 09:24:27 mujo kernel: NTFS-fs error (device 03:01): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.
> Sep 12 09:39:29 mujo kernel: NTFS-fs error (device 03:01): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.
> Sep 13 09:19:28 mujo kernel: NTFS-fs error (device 03:01): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.
> Sep 13 09:20:22 mujo kernel: NTFS-fs error (device 03:01): ntfs_ucstonls(): Unicode name contains characters that cannot be converted to character set iso8859-1.
>
>
> Are these errors serious? How can I get rid of them?

No, they are not serious. It's just warning that some file names won't be
displayed correctly. They contain some non-iso8859-1 characters. The
solution would be (writing from memory, refer to the mount manual to check
this out):
mount -o remount,iocharset=utf8 /path/where/you/mountes/ntfs/volume

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

