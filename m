Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129149AbRBHMze>; Thu, 8 Feb 2001 07:55:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129033AbRBHMzY>; Thu, 8 Feb 2001 07:55:24 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:16341 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129149AbRBHMzO>; Thu, 8 Feb 2001 07:55:14 -0500
Message-ID: <3A8296E3.FC1EE707@redhat.com>
Date: Thu, 08 Feb 2001 07:53:55 -0500
From: Doug Ledford <dledford@redhat.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.17-11 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ville Herva <vherva@viasys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Aic7xxx troubles with 2.4.1ac6
In-Reply-To: <20010208135606.F2223@viasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ville Herva wrote:
> 
> It looks like ac6 (which I believe includes the patch you posted) is
> still a no-go with 7892. The boot halts and it just prints this once a
> second:
> 
> (SCSI0:0:3:1) Synchronous at 160 Mbyte/sec offset 31
> (SCSI0:0:3:1) CRC error during data in phase
> (SCSI0:0:3:1)   CRC error in intermediate CRC packet

Check your cables, especially the connector on the card and the drive.  Look
for any possible bent pins.  The message you are seeing is *usually*, but not
always, a legitimate data corruption issue.  It doesn't show up under the
5.2.1 driver because it limits your Quantum drive to 80MByte/s and that
particular speed doesn't include CRC checking.  On this driver you have to be
running at 160MByte/s before CRC checking is enabled.

-- 

 Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
      Please check my web site for aic7xxx updates/answers before
                      e-mailing me about problems
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
