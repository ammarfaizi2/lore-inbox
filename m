Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261809AbTD0Vls (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 17:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261832AbTD0Vls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 17:41:48 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:59063 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S261809AbTD0Vlr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 17:41:47 -0400
Date: Sun, 27 Apr 2003 17:52:34 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Re: Re:  Swap Compression
In-reply-to: <20030427190444.GC5174@wohnheim.fh-wedel.de>
To: =?UNKNOWN?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: linux-kernel@vger.kernel.org
Message-id: <200304271752340880.025AB0DF@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
References: <200304251848410590.00DEC185@smtp.comcast.net>
 <20030426091747.GD23757@wohnheim.fh-wedel.de>
 <200304261148590300.00CE9372@smtp.comcast.net>
 <20030426160920.GC21015@wohnheim.fh-wedel.de>
 <200304262224040410.031419FD@smtp.comcast.net>
 <20030427090418.GB6961@wohnheim.fh-wedel.de>
 <200304271324370750.01655617@smtp.comcast.net>
 <20030427175147.GA5174@wohnheim.fh-wedel.de>
 <200304271431250990.01A281C7@smtp.comcast.net>
 <20030427190444.GC5174@wohnheim.fh-wedel.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well here's some new code.  I'll get to work on a userspace app
to compress files.  This code ONLY works on fcomp-standard
and does only one BruteForce (bmbinary is disabled) search for
redundancy.  This means three things:

1 - There's no support for messing with the pointer size and mdist/
analysis buffer size (max pointer distance)
2 - The compression ratios will not be the best.  The first match,
no matter how short, will be taken.  If it's less than 4 bytes, it will
return "no match" to the fcomp_push function.
3 - It will be slow.  BruteForce() works.  Period.  The code is too
simple for even a first-day introductory C student to screw up, and
there are NO bugs unless I truly AM a moron.  bmbinary() should
work, and the function it was coded from works in test, but neither
have been written out and proven to work by logic diagram.  It's
fast (infinitely faster than BruteForce()), but I'll try it when I feel that
the rest of the code is working right.

This should be complete for fcomp-standard.  A little alteration will
allow the fcomp-extended to work.  *Wags tail* this past two days
has been fun ^_^;

--Bluefox Icy

