Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286412AbRLTWI5>; Thu, 20 Dec 2001 17:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286410AbRLTWIr>; Thu, 20 Dec 2001 17:08:47 -0500
Received: from lacrosse.corp.redhat.com ([12.107.208.154]:40987 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S286412AbRLTWIl>; Thu, 20 Dec 2001 17:08:41 -0500
Date: Thu, 20 Dec 2001 17:08:36 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: torvalds@transmeta.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RFC: bio_vec bits, kmap_atomic
Message-ID: <20011220170836.C6276@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It looks like 2.5.2-pre1 is working towards recreating all the kvec helpers 
that I already wrote and offered in the kvec series of patches.  Do you want 
to continue recreating code, or would you like to merge?

Another issue: would you accept a patch to convert kmap_atomic into a more 
kmap-like function that only allows 2 kmaps per "context" for bounce 
copies?  As it stands, the fact that many kmap_atomic users have to disable 
interrupts is a gross wart that makes things stupidly slow.  Oh, and by 
context I'm thinking of kernel mode, bottom half, softirq and interrupt.  
This probably means hard limiting the maximum irq depth to 8 or so, but I 
suspect we need to do that 

		-ben
-- 
Fish.
