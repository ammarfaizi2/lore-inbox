Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S144431AbRA1XHd>; Sun, 28 Jan 2001 18:07:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S144446AbRA1XHY>; Sun, 28 Jan 2001 18:07:24 -0500
Received: from smtp-server.maine.rr.com ([204.210.65.66]:11497 "HELO
	smtp-server.maine.rr.com") by vger.kernel.org with SMTP
	id <S144431AbRA1XHN>; Sun, 28 Jan 2001 18:07:13 -0500
Message-ID: <000e01c0897d$bb822600$b001a8c0@caesar>
From: "paradox3" <paradox3@maine.rr.com>
To: "Trevor Hemsley" <Trevor-Hemsley@dial.pipex.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Poor SCSI drive performance on SMP machine, 2.2.16
Date: Sun, 28 Jan 2001 17:57:47 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It sounds to me like you have a SCSI bus problem. Have you checked
> termination? Cable quality? Cable lengths?

Forgive me, I'm rather ignorant of SCSI hardware.....All that I have is a
cable (appears
to be good quality, came with motherboard) about 60 centimeters long going
from the
motherboard to my hard drive. There is an unused/empty port in between.

>
> Do you have tagged queuing enabled for aic7xxx? It's a config option
> and you can adjust the maximum queue depth. You can see the current
> settings by cat /proc/scsi/aic7xxx/0
>
/proc/scsi only contains a single file named "scsi" with brief info about
the drive
According to my last save kernel config, tagged command queueing is not
enabled by default.
Could this be the problem?


> Do you have write caching enabled on the drive? scsiinfo -c /dev/sdx
> will tell you if you do.
I don't seem to have scsiinfo.

>
> As a data point, I copied a 650MB file to another file on the same
> 10krpm disk and sync'ed in about the same time it takes you to write
> 100MB. I've also copied it from a slower 7200rpm disk to my 10krpm IBM
> drive and sync'ed in 1 min 19 secs which is about the read speed of
> the slower disk.
>
> --
> Trevor Hemsley, Brighton, UK.
> Trevor-Hemsley@dial.pipex.com
>

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
