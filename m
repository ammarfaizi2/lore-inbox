Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132401AbRAXEga>; Tue, 23 Jan 2001 23:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132435AbRAXEgL>; Tue, 23 Jan 2001 23:36:11 -0500
Received: from ausxc07.us.dell.com ([143.166.99.215]:19776 "EHLO
	ausxc07.us.dell.com") by vger.kernel.org with ESMTP
	id <S132401AbRAXEgF>; Tue, 23 Jan 2001 23:36:05 -0500
Message-ID: <CDF99E351003D311A8B0009027457F1403BF9C0C@ausxmrr501.us.dell.com>
From: Matt_Domsch@Dell.com
To: ttsig@tuxyturvy.com, linux-kernel@vger.kernel.org
Subject: RE: No SCSI Ultra 160 with Adaptec Controller
Date: Tue, 23 Jan 2001 22:34:42 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom.  Thanks for writing.

> Since this machine has Quantum drives I guess this is my 
> problem.  Does anyone 
> know if this code is still actually necessary?  It seems 
> it's been there a 
> while.  It's disappointing to not get full performance out of 
> the hardware you 
> have.

Yes, that code is still necessary.  There's a new aic7xxx driver by Justin
Gibbs at Adaptec which is now being beta tested which corrects this issue.
Something to note, however: the media transfer rate for those disks is at
most ~20MB/sec.  Therefore, you only exceed the 80MB/sec bus speed if you
have more than 4 disks all doing maximum I/O at the same time.  Since the
PowerApp.web 100 has at most 2 disks internally, you really shouldn't see
any significant performance difference.

Hope this helps.
Thanks for buying Dell!
Matt Domsch
Dell Linux Systems Group
Linux OS Development


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
