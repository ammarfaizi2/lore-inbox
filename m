Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268450AbTBNN05>; Fri, 14 Feb 2003 08:26:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268448AbTBNN04>; Fri, 14 Feb 2003 08:26:56 -0500
Received: from mail.dsa-ac.de ([62.112.80.99]:64781 "HELO k2.dsa-ac.de")
	by vger.kernel.org with SMTP id <S268450AbTBNN0v>;
	Fri, 14 Feb 2003 08:26:51 -0500
Date: Fri, 14 Feb 2003 14:36:39 +0100 (CET)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.60 "Badness in kobject_register at lib/kobject.c:152"
In-Reply-To: <1045068254.2166.21.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.4.33.0302141431430.1173-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Can
> > this errors be disk-specific? (it's a SiliconTech disk, reported as
> > Hitachi) I can try some others, e.g. SunDisk.
>
> I would be interested to see how they compare

Ok, finally I was able to do a comparison. SanDisk does look a bit better:

> > hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: task_no_data_intr: error=0x04 { DriveStatusError }
>
> This is it rejecting a command at start up, thats ok. I do need to
> quieten these further yet.

And they still appear with SanDisk.

> > hda: 31488 sectors (16 MB) w/1KiB Cache, CHS=246/4/32, BUG <=============
>
> Curious. I'll tae a look

And this one too.

> > then, on mounting root again
> > hda: task_no_data_intr: status=0x51 { DriveReady SeekComplete Error }
> > hda: task_no_data_intr: error=0x04 { DriveStatusError }
> > hda: Write Cache FAILED Flushing!
>
> For some reason we decided the drive support cache flush. However it
> apparently doesnt

The last of the above errors does not appear on SanDisk - it supports
cache flush?

Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany

