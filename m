Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262263AbULMN6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262263AbULMN6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 08:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbULMN6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 08:58:49 -0500
Received: from mail45.messagelabs.com ([140.174.2.179]:48108 "HELO
	mail45.messagelabs.com") by vger.kernel.org with SMTP
	id S262263AbULMN6F convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 08:58:05 -0500
X-VirusChecked: Checked
X-Env-Sender: justin.piszcz@mitretek.org
X-Msg-Ref: server-20.tower-45.messagelabs.com!1102946282!8365052!1
X-StarScan-Version: 5.4.2; banners=-,-,-
X-Originating-IP: [66.10.26.57]
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Unknown Issue.
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Date: Mon, 13 Dec 2004 08:57:59 -0500
Message-ID: <2E314DE03538984BA5634F12115B3A4E01BC4175@email1.mitretek.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Unknown Issue.
Thread-Index: AcTgkJ/dRlq7soY5R9KEgCqtJn8YywAiXCUg
From: "Piszcz, Justin Michael" <justin.piszcz@mitretek.org>
To: "Patrick" <nawtyness@gmail.com>, <linux-kernel@vger.kernel.org>,
       <linux-xfs@oss.sgi.com>
Cc: "Andrew Morton" <akpm@osdl.org>,
       "Kristofer T. Karas" <ktk@enterprise.bidmc.harvard.edu>,
       "Jeff Garzik" <jgarzik@pobox.com>, "Linus Torvalds" <torvalds@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick,

I had the same problem on two machines with XFS.  Both slackware-current
machines.  The kernel on the Dell GX1 was built with GCC-3.4.2 and on my
main box was GCC-3.4.3.

There seems to be a bug in XFS with some configurations of 2.6.9 and
2.6.10-rc series.

After re-installing Slackware-10.0 and upgrading to -current, I have
installed 2.6.10-rc3 and so far, I have not been able to reproduce the
problem.

Some questions for you:

1] What kernel are you running?
2] What did you last change before you started getting these errors?

As far as severity goes, I ran XFS' fsck from a KNOPPIX CD and as a
result, I had about 500-600mb of files in my /lost+found directory when
it was finished.  Files were missing from all parts of the file system.
I had to restore from backup.  I would say stick with your previous
2.6.9 configuration (if you were running it) or go back to 2.6.8.1, some
2.6.9 configurations and 2.6.10-rc1 and/or 2.6.10-rc2 definitely cause
file corruption with XFS.  So far, however, I have not been able to
reproduce the error with 2.6.10-rc3.

Justin.

-----Original Message-----
From: linux-kernel-owner@vger.kernel.org
[mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Patrick
Sent: Sunday, December 12, 2004 4:15 PM
To: linux-kernel@vger.kernel.org
Subject: Unknown Issue.

Hi, 

I've got a computer running gentoo, on a clean install where i've got
an odd problem :

after a while, the computer refuses to spawn processes anymore : 

-/bin/bash: /bin/ps: Input/output error
-/bin/bash: /usr/bin/w: Input/output error
-/bin/bash: /bin/df: Input/output error
-/bin/bash: /bin/mount: Input/output error

It happen's randomly, i've tried everything from changing the computer
from running software raid ( scsi ) to running a hardware solution and
reinstalling, I've run the memory through memtest as well as i've
remounted the drives and i've tested the ram to make sure it was
properly mounted.

The only thing running on this box is mysql, which runs perfectly at
7500 q/s ( running super smack ) now, i'm not sure if this is a linux
kernel thing, or a gentoo thing, or a hardware thing.

I've checked and i'm not running out of file descriptors ( by looking
in /proc/sys/fs/file-nr ) and i've increased the ammount in (
/proc/sys/fs/file-max ( if i member correctly ) ) by adding a 0 after
the end of the value thus increasing it alot.

It's running XFS on the root partition with a single partition, dual
xeon 2.66 with hyperthreading enabled, dual intel gbe and a adaptec
2120S AACraid card. Dual 36gb 10krpm scsi drives in raid1.

Does anyone have any ideas on what i can do, what i can test, if it's
hardware ? software ?

guys ? 

P

-- 
</N>

------
In the beginning, there was nothing. And God said, 'Let there be
Light.' And there was still nothing, but you could see a bit better.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel"
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
