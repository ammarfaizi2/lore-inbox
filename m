Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293006AbSCEKN2>; Tue, 5 Mar 2002 05:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293008AbSCEKNS>; Tue, 5 Mar 2002 05:13:18 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:36253 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S293006AbSCEKM7> convert rfc822-to-8bit; Tue, 5 Mar 2002 05:12:59 -0500
Importance: Normal
Subject: Re: s390 is totally broken in 2.4.18
To: linux-kernel@vger.kernel.org
Cc: zaitcev@redhat.com
X-Mailer: Lotus Notes Release 5.0.4a  July 24, 2000
Message-ID: <OF6510BC1D.720C525B-ONC1256B73.003619EE@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Tue, 5 Mar 2002 11:10:37 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.8 |June 18, 2001) at
 05/03/2002 11:15:33
MIME-Version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

>Apparently, NOBODY bothered to test 2.4.18-pre*, 2.4.18 final,
>or 2.4.19-pre* on s390. The broken patch went into 2.4.18-pre1
>with a curt changelog:
>
>- S390 merge (IBM)
The patch that was merged in 2.4.18-pre* has been created against
2.4.17-pre7 and it did work. The problem is that not all of the
changes I sent Marcelo have been accepted. One of the patches was
the asm-offsets fix that removes all of the hardcoded offsets from
entry.S. Another patch was accepted that changed the thread
structure and this created the inconsistency.

>Patch attached.
Well your patch halfway fixes one of the problems. Halfway because
not the fp_regs structure has changed its size but the pt_regs
pointer has been removed from the thread structure.
Incidentally I sent an s390 update to Marcelo yesterday and the
minimal fixes including an rwsem.h implementation and the partition
detection fixes are about 2000 lines. Want a copy ?

blue skies,
   Martin

Linux/390 Design & Development, IBM Deutschland Entwicklung GmbH
Schönaicherstr. 220, D-71032 Böblingen, Telefon: 49 - (0)7031 - 16-2247
E-Mail: schwidefsky@de.ibm.com


