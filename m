Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266790AbUHURZH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266790AbUHURZH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 13:25:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUHURZH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 13:25:07 -0400
Received: from mx.inch.com ([216.223.198.27]:57353 "EHLO util.inch.com")
	by vger.kernel.org with ESMTP id S266790AbUHURZA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 13:25:00 -0400
Date: Sat, 21 Aug 2004 13:26:46 -0400
From: John McGowan <jmcgowan@inch.com>
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.8.1: memory leak? cdrecord problem?
Message-ID: <20040821172646.GA8781@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

KERNEL 2.6.8.1: Memory leak? CDrecord problem?

-----------------------------------
KERNEL 2.6.7: compiled cdrecord.
 Works fine. Burns data disks fine.
 Burns audio disks fine.

UPGRADED TO KERNEL 2.6.8.1 (using the patches):
 Used version of cdrecord compiled under 2.7
 Burns data disks fine.
 I have 256 Meg RAM (and 500+ Meg swap).
 Burning a 400+Meg wav file to audio CD (40+minute
 radio show) causes, after 130-180Meg have been
 burned (depending on what I am running):

   OUT OF MEMORY: closing down atd

  and memory keeps being used up:
 
   OUT OF MEMORY: closing down cupsd
   OUT OF MEMORY: closing down crond
   (etc.)
  
  If I am lucky, cdrecord gets closed down before
  something critical gets killed.
  Often I am unlucky.

UNDER KERNEL 2.6.8.1:
 Recompiled cdrecord under 2.6.8.1.
 Burns data disks fine.
 Burning a 400+ Meg wav file to audio CD causes:

   OUT OF MEMORY: closing down atd
   OUT OF MEMORY: closing down cupsd
   OUT OF MEMORY: closing down crond
   (etc.)

(Fedora Core1; kernel upgraded to (now) 2.6.7
               (I went back to 2.6.7 so I could
                burn audio CDs)
               Using Pioneer DVD burner with ATAPI
               (dev=ATAPI:0,0,0 in cdrecord) interface.)
