Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265378AbSK1QNB>; Thu, 28 Nov 2002 11:13:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265537AbSK1QNB>; Thu, 28 Nov 2002 11:13:01 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:13719 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265378AbSK1QNB>; Thu, 28 Nov 2002 11:13:01 -0500
Subject: Re: 2.4.19-rc1,2 + ext3 data=journal: data loss on unmount
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Piggin, Nick" <Nick.Piggin@cit.act.edu.au>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <C1126026D9293645B970FB72C66907961F53EE@rdmail.cit.act.edu.au>
References: <C1126026D9293645B970FB72C66907961F53EE@rdmail.cit.act.edu.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Nov 2002 16:52:07 +0000
Message-Id: <1038502327.10021.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 07:12, Piggin, Nick wrote:
> mount /mnt/backup
> tar cvf $FILENAME directory
> bzip2 $FILENAME
> umount /mnt/backup
> 
> Upon remounting and inspection, the resulting bzip2 file is corrupted every
> time. Adding a sync after bzip2 corrects the problem.

That sounds like a bug in the core code somewhere since the flush should
have happened automatically on umount. Does 2.4.19 proper show this on
your box (or 2.4.20-rc) ? [I'd suspect yes but would like to be sure]

