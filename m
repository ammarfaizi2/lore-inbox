Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291705AbSBHSZy>; Fri, 8 Feb 2002 13:25:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291704AbSBHSZr>; Fri, 8 Feb 2002 13:25:47 -0500
Received: from host194.steeleye.com ([216.33.1.194]:20235 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S291705AbSBHSZd>; Fri, 8 Feb 2002 13:25:33 -0500
Message-Id: <200202081825.g18IPSf03107@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: torvalds@transmeta.com
cc: linux-kernel@vger.kernel.org, James.Bottomley@HansenPartnership.com
Subject: [PATCH: NEW ARCHITECTURE FOR 2.5.3] support for NCR voyager
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 08 Feb 2002 13:25:27 -0500
From: James Bottomley <James.Bottomley@HansenPartnership.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is essentially the same as the 2.5.2 patch except that it adds support 
for the new migration cross processor interrupt.

As far as the new scheduler goes, the process affinity properties are much 
better for the voyager, which is configured to have a fairly huge L3 cache 
shared by several CPUs.  (My current voyager has 2 CPU cards with 4 pentium 
CPUs each and 32Mb of L3 cache on each card).

The patch (157k) is available here

http://www.hansenpartnership.com/voyager/files/voyager-2.5.3.diff

If there's any interest from the other architecture groups, I can also put 
together the incremental diff between 2.5.2 and 2.5.3 which shows what changes 
needed to be made in the arch specific boot sequence and smp code for the new 
scheduler.

James Bottomley


