Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267611AbTCFAvM>; Wed, 5 Mar 2003 19:51:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267595AbTCFAvM>; Wed, 5 Mar 2003 19:51:12 -0500
Received: from hera.cwi.nl ([192.16.191.8]:57277 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S267577AbTCFAvK>;
	Wed, 5 Mar 2003 19:51:10 -0500
From: Andries.Brouwer@cwi.nl
Date: Thu, 6 Mar 2003 02:01:38 +0100 (MET)
Message-Id: <UTC200303060101.h2611cg08660.aeb@smtp.cwi.nl>
To: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
       torvalds@transmeta.com
Subject: 2.5.63/64 do not boot: loop in scsi_error
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

See that 2.5.64 came out - good. Time to send the next dev_t patch.
Unfortunately 2.5.63 and 2.5.64 do not boot.

A moment ago I looked at what goes wrong, and it turns out that
scsi_error is activated
  [always a bad sign - I have never see it do any good, and
   often see it crash the machine]
and an infinite loop occurs, leaving the machine rather dead.

(Total of 1 commands require eh work; scsi_unjam_host; requesting sense;
 scsi_eh_done: result 0) - infinite repeat.

Have no time tonight to make a patch, but I suppose the author of
the 2.5.63 scsi_error.c changes knows what she did wrong.

Andries


[I can make 2.5.64 boot if I make sure no errors ever occur.
That means that I must disable get_evpd_page, get_serialnumber,
get_cachetype that my old stuff doesnt know about.
If I do that all is well.]
