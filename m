Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUGAB6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUGAB6e (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 21:58:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbUGAB6e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 21:58:34 -0400
Received: from mta02-svc.ntlworld.com ([62.253.162.42]:5363 "EHLO
	mta02-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id S263714AbUGAB6c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 21:58:32 -0400
Subject: Trouble with the filesize limit
From: Steven Newbury <steven.newbury1@ntlworld.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1088647102.6630.15.camel@timescape.home.snewbury.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 01 Jul 2004 02:58:22 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
I'm been trying to download the DVD ISO for FC2.  But I've run into a
problem.  It isn't possible for me to download more than 2GiB.  Other
people have been having the same problem (see the d4x message board).  I
haven't been able to trace the exact cause for the limit "ulimit -f"
reports unlimited and I'm running reiserfs with 3.6 format filesystem
(in theory supports much more than 2GiB).  I've tried programs d4x, wget
etc., each of them have received a SIGXFSZ and exited at 2GiB.

Strangely I am able to create much larger files with dd.

This sounds like a similar bug to one that was fixed in 2.4, where the
limit was always 2GiB unless logged in directly as root.  However in
this case even that doesn't work.

kernel 2.6.7-ck1
glibc 2.3.3-27 (fedora core)
bash 2.05b-38 (fedora core)

Any other info on request.

-- 
Steven Newbury <steven.newbury1@ntlworld.com>

