Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316235AbSEQOZP>; Fri, 17 May 2002 10:25:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316236AbSEQOZO>; Fri, 17 May 2002 10:25:14 -0400
Received: from 209-6-202-152.c3-0.nwt-ubr1.sbo-nwt.ma.cable.rcn.com ([209.6.202.152]:26098
	"EHLO chezrutt.dyndns.org") by vger.kernel.org with ESMTP
	id <S316235AbSEQOZM>; Fri, 17 May 2002 10:25:12 -0400
From: John Ruttenberg <rutt@chezrutt.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15589.4802.37068.931146@localhost.localdomain>
Date: Fri, 17 May 2002 10:25:06 -0400
To: linux-kernel@vger.kernel.org
Subject: Dell Inspiron i8100 with 2 batteries
X-Mailer: VM 6.96 under Emacs 20.7.1
Reply-to: rutt@chezrutt.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried sending this to linux-laptop and got no response, so I thought I try a
larger audience:

I am using 2.4.18 and have a Dell I8100 with 2 batteries.  If combined charge
of the batteries is less than 50% (according to the bios), then /proc/apm
shows the battery power level X 2.  If the combined charge of the batteries is
greater than 50%, then /proc/apm shows:

    1.16 1.2 0x03 0x01 0xff 0x10 -1% -1 ?

I think this is because the bogus calculation it would make would result in a
percentage > 100.

I took a quick look at arch/i386/kernel/apm.c but it wasn't obvious what to
do.

Does anyone else have any experience with this?
