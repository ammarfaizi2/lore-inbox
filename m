Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274804AbTHFWlX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 18:41:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274982AbTHFWlD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 18:41:03 -0400
Received: from iwoars.net ([217.160.110.113]:37647 "HELO iwoars.net")
	by vger.kernel.org with SMTP id S274997AbTHFWjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 18:39:32 -0400
Date: Thu, 7 Aug 2003 00:40:22 +0200
From: Thomas Themel <themel@iwoars.net>
To: linux-kernel@vger.kernel.org
Subject: Device-backed loop broken in 2.6.0-test2?
Message-ID: <20030806224022.GA3741@iwoars.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Jabber-ID: themel0r@jabber.at
X-ICQ-UIN: 8774749
X-Postal: Hauptplatz 8/4, 9500 Villach, Austria
X-Phone: +43 676 846623 13
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it seems that device backed loopback is broken in the 2.6.0-test2 series.

I've noticed the error while testing cryptoloop, but it still appears
reliably when using plain loop without encryption.

I set up a loopback device on an IDE partition

losetup /dev/loop0 /dev/hda6

and create an ext3 filesystem on it. Then, when trying to fill it with
data, it works for a while until errors of the form 

Buffer I/O error on device loop0, logical block 377367
Buffer I/O error on device loop0, logical block 377380
Buffer I/O error on device loop0, logical block 377419
Buffer I/O error on device loop0, logical block 378937
Buffer I/O error on device loop0, logical block 378983
Buffer I/O error on device loop0, logical block 380008
Buffer I/O error on device loop0, logical block 380009

start to appear in the kernel log. This does not affect the writes,
however, and only manifests later when the filesystem breaks or data in
files is corrupted. 

ciao,
-- 
[*Thomas  Themel*] I read what some of you folks here write and all I can
[extended contact] say is that I hope you are inside the fireballs when the
[info provided in] freedom fighters take out the Great Satan.
[*message header*]	- Tim May on cypherpunks
