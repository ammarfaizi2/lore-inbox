Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTILQs4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 12:48:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261744AbTILQsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 12:48:55 -0400
Received: from mail.telpin.com.ar ([200.43.18.243]:23518 "EHLO
	mail.telpin.com.ar") by vger.kernel.org with ESMTP id S261743AbTILQsy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 12:48:54 -0400
Date: Fri, 12 Sep 2003 13:48:42 -0300
From: Alberto Bertogli <albertogli@telpin.com.ar>
To: linux-kernel@vger.kernel.org, viro@parcelfarce.linux.theplanet.co.uk
Subject: file_lock_cache won't shink down
Message-ID: <20030912164842.GJ6971@telpin.com.ar>
Mail-Followup-To: Alberto Bertogli <albertogli@telpin.com.ar>,
	linux-kernel@vger.kernel.org,
	viro@parcelfarce.linux.theplanet.co.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
X-RAVMilter-Version: 8.4.2(snapshot 20021217) (mail)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there!

I've put 2.6.0-test5 yesterday on a mail server and today I noticed that
there was a huge amount of memory 'missing' from vmstat.

So I took a look at slabinfo and found out that file_lock_cache has a huge
amount of objects that won't shink down even under memory pressure.

The line, as it is now, looks like:
file_lock_cache   5828600 5828600     96   40    1 : tunables  120   60 \
	8 : slabdata 145715 145715      0

The whole slabinfo is attached.

This is a dual Pentium III with 1Gb RAM and three SCSI disks in two
Adaptec aic7896/97.

I don't know if I can hold the server up for much longer so please if you
want me to get any other information let me know.


Thanks a lot,
		Alberto


