Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbTJCMwT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Oct 2003 08:52:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263748AbTJCMwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Oct 2003 08:52:19 -0400
Received: from 11.ylenurme.ee ([193.40.6.11]:20869 "EHLO linking.ee")
	by vger.kernel.org with ESMTP id S263733AbTJCMwS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Oct 2003 08:52:18 -0400
Message-ID: <47897.195.80.106.123.1065189072.squirrel@mail.linking.ee>
Date: Fri, 3 Oct 2003 15:51:12 +0200 (EET)
Subject: BUG: softraid,ext3 lockup
From: <elmer@linking.ee>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
X-Mailer: SquirrelMail (version 1.2.6)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


2.4.22 this time, on Xeon x335, / is raid1+ext3, journal size=128M

dd if=/dev/zero of=/tmp/jama bs=1M count=1000

on other softraid servers I have, this gets load to 3-4 , performance is
bad, the same behaviour is present, but tolerable.
Dual Xeon(exact same HW and conf with 2 cpus) now is about tolerable also

single  Xeon, with or without ht, still gets very stuck, load goes quickly
7-9, ls /directoryNotInCache takes 10 secs, cpu is idle, related processes
are in D state, as / is on same raid,everything sucks like hell..
additionally, something that might give a clue: when I mount the partition
with noatime, load gets quickly to 30...40..50
Elmer.







