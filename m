Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129524AbQKGNHb>; Tue, 7 Nov 2000 08:07:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129121AbQKGNHV>; Tue, 7 Nov 2000 08:07:21 -0500
Received: from kendy.up.ac.za ([137.215.101.101]:52749 "EHLO kendy.up.ac.za")
	by vger.kernel.org with ESMTP id <S129807AbQKGNHD>;
	Tue, 7 Nov 2000 08:07:03 -0500
Message-ID: <3A07FC3D.13663547@suntiger.ee.up.ac.za>
Date: Tue, 07 Nov 2000 14:57:33 +0200
From: Justin Schoeman <justin@suntiger.ee.up.ac.za>
Reply-To: justin@suntiger.ee.up.ac.za
Organization: University of Pretoria
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe Woodward <woodey@twasystems.fsnet.co.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: removable EIDE disks
In-Reply-To: <000001c048ae$6132c340$6904883e@default>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Joe Woodward wrote:
> 
> I am trying to use removable EIDE hard disks on a Red Hat Linux 6.1
> machine, for backup / walknet purposes.
> 
> Issuing a BLKRRPART ioctl call immediately after changing the disk
> works, but only if the new disk is no larger than the disk present at
> boot time (smaller and equal capacity disks work OK).
> 
> How do I get Linux to recognise that the media in /dev/hdc has
> changed?
> 
> Bill Nottingham suggested that I ask you, as he is unsure if this is a
> bug or if there is a technique that I am missing.
> 
> 
> Thanks
> 
> Richard Stanton
> 
> rich@twasystems.fsnet.co.uk
> 

Try using the HDIO_SCAN_HWIF ioctl instead.  This is what I have been
using, and it work(ed) just fine. (It seems to result in hard locks on
the newer 2.2.x, where x>14, kernels though).

-justin
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
