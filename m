Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129047AbRBHAiq>; Wed, 7 Feb 2001 19:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129282AbRBHAig>; Wed, 7 Feb 2001 19:38:36 -0500
Received: from mail.heymax.com ([63.96.5.101]:58896 "EHLO heymax.com")
	by vger.kernel.org with ESMTP id <S129047AbRBHAiY>;
	Wed, 7 Feb 2001 19:38:24 -0500
From: "Jason Ford" <jason@heymax.com>
To: "Byron Stanoszek" <gandalf@winds.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: aacraid 2.4.0 kernel
Date: Wed, 7 Feb 2001 19:37:38 -0500
Message-ID: <PNEPLDDEADCDEBANKDDHMEGPCAAA.jason@heymax.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
Importance: Normal
In-Reply-To: <Pine.LNX.4.21.0102071746060.7611-100000@winds.org>
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.3018.1300
X-MDRemoteIP: 10.0.1.21
X-Return-Path: jason@heymax.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Byron,

I got your patch to compile in fine however it still exhibits the same
behavior that the older patches did. It looks like the commands sent to the
controller are still not working correctly as the new subsystem in the
kernel was rewritten.

This is the error I get in my messages file when trying to copy from one
disk partition to another one.

Feb  7 19:32:11 bass kernel: SCSI disk error : host 0 channel 0 id 0 lun 0
return code = 1
Feb  7 19:32:11 bass kernel:  I/O error: dev 08:08, sector 657672
Feb  7 19:32:11 bass kernel:
Feb  7 19:32:11 bass kernel:
Feb  7 19:32:11 bass kernel: AacHba_`DoScsiWrite: WRITE request is larger
than 64K
Feb  7 19:32:11 bass kernel: AacHba_DoScsiWrite: ByteCount: 69632
Feb  7 19:32:11 bass kernel: AacHba_DoScsiWrite: SG ELEMENTS: 16
Feb  7 19:32:11 bass kernel: Dump SG Element Size...
Feb  7 19:32:11 bass kernel: SG Segment 0: 4096
Feb  7 19:32:11 bass kernel: SG Segment 1: 4096
Feb  7 19:32:11 bass kernel: SG Segment 2: 4096
Feb  7 19:32:11 bass kernel: SG Segment 3: 4096
Feb  7 19:32:11 bass kernel: SG Segment 4: 4096
Feb  7 19:32:11 bass kernel: SG Segment 5: 4096
Feb  7 19:32:11 bass kernel: SG Segment 6: 4096
Feb  7 19:32:11 bass kernel: SG Segment 7: 8192
Feb  7 19:32:11 bass kernel: SG Segment 8: 4096
Feb  7 19:32:11 bass kernel: SG Segment 9: 4096
Feb  7 19:32:11 bass kernel: SG Segment 10: 4096
Feb  7 19:32:11 bass kernel: SG Segment 11: 4096
Feb  7 19:32:11 bass kernel: SG Segment 12: 4096
Feb  7 19:32:11 bass kernel: SG Segment 13: 4096
Feb  7 19:32:11 bass kernel: SG Segment 14: 4096
Feb  7 19:32:11 bass kernel: SG Segment 15: 4096
Feb  7 19:32:11 bass kernel:
Feb  7 19:32:12 bass kernel:
Feb  7 19:32:12 bass kernel: SCSI disk error : host 0 channel 0 id 0 lun 0
return code = 1
Feb  7 19:32:12 bass kernel:  I/O error: dev 08:08, sector 665864
Feb  7 19:32:12 bass kernel:
Feb  7 19:32:12 bass kernel:
Feb  7 19:32:12 bass kernel: AacHba_`DoScsiWrite: WRITE request is larger
than 64K
Feb  7 19:32:12 bass kernel: AacHba_DoScsiWrite: ByteCount: 69632
Feb  7 19:32:12 bass kernel: AacHba_DoScsiWrite: SG ELEMENTS: 16
Feb  7 19:32:12 bass kernel: Dump SG Element Size...
Feb  7 19:32:12 bass kernel: SG Segment 0: 4096
Feb  7 19:32:12 bass kernel: SG Segment 1: 4096
Feb  7 19:32:12 bass kernel: SG Segment 2: 4096
Feb  7 19:32:12 bass kernel: SG Segment 3: 4096
Feb  7 19:32:12 bass kernel: SG Segment 4: 4096
Feb  7 19:32:12 bass kernel: SG Segment 5: 4096
Feb  7 19:32:12 bass kernel: SG Segment 6: 4096
Feb  7 19:32:12 bass kernel: SG Segment 7: 4096
Feb  7 19:32:12 bass kernel: SG Segment 8: 8192
Feb  7 19:32:12 bass kernel: SG Segment 9: 4096
Feb  7 19:32:12 bass kernel: SG Segment 10: 4096
Feb  7 19:32:12 bass kernel: SG Segment 11: 4096
Feb  7 19:32:12 bass kernel: SG Segment 12: 4096
Feb  7 19:32:12 bass kernel: SG Segment 13: 4096
Feb  7 19:32:12 bass kernel: SG Segment 14: 4096
Feb  7 19:32:12 bass kernel: SG Segment 15: 4096
Feb  7 19:32:12 bass kernel:
Feb  7 19:32:12 bass kernel:

so on and so on.. Am I doing something wrong?

Thanks for your reply post..

Jason


-----Original Message-----
From: Byron Stanoszek [mailto:gandalf@winds.org]
Sent: Wednesday, February 07, 2001 5:48 PM
To: Jason Ford
Cc: linux-kernel@vger.kernel.org
Subject: Re: aacraid 2.4.0 kernel


On Wed, 7 Feb 2001, Jason Ford wrote:

> I see in the archives of this mailing list that someone was working on the
> aacraid driver for the 2.4 kernel however that post was almost 2 months
old.
> I know Alan Cox denied inclusion of the driver due to the poor nature it
was
> written for the 2.2 tree. Every post that I have seen so far has just said
> that Adaptec is working on it. However, I am sure there are many people
out
> there like myself that have to support this card in enviroments that would
> be benifical to upgrade to 2.4 kernel. I am not a part of this list
however
> have been scouring through geocrawler.com archives of this list everyday
for
> the last month hoping and waiting.

While it's totally unofficial, I have a patch for aacraid 1.0.6 for
2.4.1-ac5.
I have not tested it yet, but it compiles cleanly. I'd like to hear any
results
(good or bad) you have on it.

You can find it at:

  ftp://ftp.winds.org/linux/patches/2.4.1/aacraid-2.4.1-1.0.6.patch

Regards,
 Byron

--
Byron Stanoszek                         Ph: (330) 644-3059
Systems Programmer                      Fax: (330) 644-8110
Commercial Timesharing Inc.             Email: byron@comtime.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
