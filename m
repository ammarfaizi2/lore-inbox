Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267512AbTAQOzH>; Fri, 17 Jan 2003 09:55:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267528AbTAQOzH>; Fri, 17 Jan 2003 09:55:07 -0500
Received: from host194.steeleye.com ([66.206.164.34]:43274 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S267512AbTAQOzH>; Fri, 17 Jan 2003 09:55:07 -0500
Message-Id: <200301171503.h0HF3vr02010@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Zwane Mwaikambo <zwane@holomorphy.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH][2.5] fix for_each_cpu compilation on UP 
In-Reply-To: Message from Zwane Mwaikambo <zwane@holomorphy.com> 
   of "Fri, 17 Jan 2003 00:01:10 EST." <Pine.LNX.4.44.0301162358060.24250-100000@montezuma.mastecende.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 Jan 2003 10:03:55 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zwane@holomorphy.com said:
> This adds a definition for for_each_cpu when !CONFIG_SMP
> Please apply 

Could you elaborate on the purpose of this a bit?  for_each_cpu() is only used 
by the voyager subarch on x86 to traverse sparse CPU bitmaps efficiently in 
critical path code.  It has no other use in x86 SMP because all other 
subarch's tend to compact the CPU bitmap much more.

If there are other uses for the construct, it should probably be put in bitops 
and become for_each_bit(i, mask)

James


