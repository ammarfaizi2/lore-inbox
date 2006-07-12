Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWGLAQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWGLAQX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 20:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWGLAQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 20:16:23 -0400
Received: from 58.105.229.78.optusnet.com.au ([58.105.229.78]:36522 "EHLO
	adsl-kenny.stuart.id.au") by vger.kernel.org with ESMTP
	id S932287AbWGLAQW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 20:16:22 -0400
Subject: Problems with oom killer
From: Russell Stuart <russell-lkml@stuart.id.au>
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Wed, 12 Jul 2006 10:15:12 +1000
Message-Id: <1152663312.4267.20.camel@ras.pc.brisbane.lube>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The oom killer is being run, and I can't figure out why.
As far as I can see there is plenty of memory available.
Attached are some logs that show that state of the machine
when the oom killer runs.

Background info: The machine has 2Gb of RAM, and 2Gb of
swap.  The oom killer consistently strikes when the
machine is doing a backup.  The backup consists of
mkfs'ing an ext3 partition, and then copying the files
across.  The oom killer does its stuff during the mkfs.
It goes away ones the next ext3 partition is mounted
and the backup starts.

It is running the Debian stable kernel (2.6.8.1) with
cfq on a dual core machine.  Although it shouldn't be,
it appears the machine is used a very high load at the
time because the shell script attached is supposed to
run every 5 seconds, yet at the time the oom condition
happens there is approx 10 minute delay between runs.

Two other odd things: there are many other machines
that are identical software wise, as in installed from 
the same DVD image, and doing an identical backup.  
This is the only one with the issue.  This box has
just been replaced and a fresh install done.  The 
previous box (completely different hardware) had the
same issue.

Any clues would be appreciated.

--

Regards,
Russell Stuart

