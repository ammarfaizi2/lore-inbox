Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288975AbSAFQFz>; Sun, 6 Jan 2002 11:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288977AbSAFQFp>; Sun, 6 Jan 2002 11:05:45 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:5124 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288975AbSAFQFd>; Sun, 6 Jan 2002 11:05:33 -0500
Subject: Re: i686 SMP systems with more then 12 GB ram with 2.4.x kernel ?
To: bcrl@redhat.com (Benjamin LaHaise)
Date: Sun, 6 Jan 2002 16:16:07 +0000 (GMT)
Cc: gerrit@us.ibm.com (Gerrit Huizenga), alan@lxorguk.ukuu.org.uk (Alan Cox),
        znmeb@aracnet.com (M. Edward Borasky),
        harald.holzer@eunet.at (Harald Holzer), linux-kernel@vger.kernel.org
In-Reply-To: <20020106032030.A27926@redhat.com> from "Benjamin LaHaise" at Jan 06, 2002 03:20:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16NFxv-0005e4-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> up as a 5% performance loss on normal loads, and this would make it 
> worse.  We're probably better off implementing PSE.  Of course, making 
> these kinds of choices is hard without actual statistics of the 
> usage patterns we're targetting.

You don't neccessarily need PSE. Migrating to an option to support > 4K
_virtual_ page size is more flexible for x86, although it would need 
glibc getpagesize() fixing I think, and might mean a few apps wouldnt
run in that configuration.

Alan
