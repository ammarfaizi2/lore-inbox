Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265023AbTFWCdA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 22:33:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265039AbTFWCdA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 22:33:00 -0400
Received: from smtp-out.comcast.net ([24.153.64.116]:62064 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S265023AbTFWCcy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 22:32:54 -0400
Date: Sun, 22 Jun 2003 22:41:28 -0400
From: rmoser <mlmoser@comcast.net>
Subject: Supermount (NOT Mandrake!)
To: linux-kernel@vger.kernel.org
Message-id: <200306222241280320.0835BB0F@smtp.comcast.net>
MIME-version: 1.0
X-Mailer: Calypso Version 3.30.00.00 (3)
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, Mandrake's supermount is marked as stable, and it's broken
and a piece of shit.  However, supermount is useful on the iPaq and
convienient in other places as well.  I'm going to work out a somewhat
workable alternative to that, and try to impliment it.  Once I fail at that
(some outlook on life I have, huh?), I'll put the proposal up on here for
you all to take a shot at.

One of the things I'm thinking about is multiple partition devices.  For
example, Zip disks.  Some of us make a Zip disk a single filesystem,
with no partition table: `mount /dev/sda /zip`.  Others leave the 4
partitions on the Zip disk when they get it:  `mount /dev/sda4 /zip`.
What to do, what to do.

Of course the answer's simple.
`mount supermount /zip -o device=/dev/sda,user`, and if we have 4 partitions,
/zip becomes mod a-w, and 4 new directories appear:  /zip/1 /zip/2 /zip/3
/zip/4.  Then supermount mounts each partition on each of those, if
possible.  If it's a broken partition (/dev/sda[1-3] on a new zip disk), it's just
marked mod a-w.

Question:  Can I do this?  I've never programmed in the kernel before but i've
tried several times.  I know about the automounter.  Can I control it from a
virtual filesystem device?  Like, on accessing /zip, could those dirs be created
virtually, then suddenly a supermount mounted on each of them?  I have no
idea what I'm doing but I'm trying!

I'm gonna send this before I feel too stupid to.

--Bluefox Icy

