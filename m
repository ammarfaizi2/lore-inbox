Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262469AbTCKA3u>; Mon, 10 Mar 2003 19:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262500AbTCKA3u>; Mon, 10 Mar 2003 19:29:50 -0500
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:42761 "EHLO
	adelphi.physics.adelaide.edu.au") by vger.kernel.org with ESMTP
	id <S262469AbTCKA3t>; Mon, 10 Mar 2003 19:29:49 -0500
From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Message-Id: <200303110040.h2B0eLu05319@sprite.physics.adelaide.edu.au>
Subject: Re: Oops: kernel 2.4.20, ide-scsi, cdrecord 1.11a24
To: linux-kernel@vger.kernel.org
Date: Tue, 11 Mar 2003 11:10:21 +1030 (CST)
Cc: jwoithe@physics.adelaide.edu.au (Jonathan Woithe)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all

This is a followup to my previous message regarding a consistant
reproducable oops under 2.4.20 when burning CDs using cdrecord and ide-scsi.

Last night I tried disabling DMA on the CD drive (it was enabled by
default):
  hdparm -d0 -c1 /dev/hdc

Following this, two dummy writes (700MB and 680MB respectively) proceeded
normally and completed without errors.  Given that under 2.4.20 the dummy
writes usually failed very quickly (after around 7-30MB), it would appear
that in the first instance at least, DMA must be disabled for ide-scsi CD
writers under 2.4.20 in order for burning to be reliable.

Obviously this isn't the intended behaviour though; is anyone aware of this
issue and/or is it being worked on for 2.4/2.5 as appropriate?

Best regards
  jonathan
-- 
* Jonathan Woithe    jwoithe@physics.adelaide.edu.au                        *
*                    http://www.physics.adelaide.edu.au/~jwoithe            *
***-----------------------------------------------------------------------***
** "Time is an illusion; lunchtime doubly so"                              **
*  "...you wouldn't recognize a subtle plan if it painted itself purple and *
*   danced naked on a harpsichord singing 'subtle plans are here again'"    *
