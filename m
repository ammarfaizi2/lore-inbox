Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263898AbUCPLIP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 06:08:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263899AbUCPLIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 06:08:15 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:22761 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S263898AbUCPLIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 06:08:13 -0500
Subject: [PROBLEM] Firewire-related crashes in 2.6.4
From: Tillmann Steinbrecher <t-st@t-st.org>
To: linux-kernel@vger.kernel.org, bcollins@debian.org
Content-Type: text/plain
Message-Id: <1079438920.2947.10.camel@paranoia.pallasnet.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 13:08:40 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

although not as unstable as in 2.6.3, the usage of my external FireWire
drive (Plextor 708A DVD burner with Oxford 911 FireWire interface) is
still causing freezes. This time the freezes occur randomly when reading
files from the drive, or when trying to rip a video DVD. It's a hard
crash - no mouse movement, no ping on the network. It is not always
reproducible, but occurs frequently.

Here's a screenshot of the resulting kernel panic (sorry for the .jpg, I
couldn't paste it as text, for obvious reasons):

http://www.t-st.org/panic.jpg

Here's my kernel .config:
http://www.t-st.org/kconf.txt

And here lspci:
http://www.t-st.org/lspci.txt

The system was running fine with identical config under 2.6.0, 2.6.1,
2.6.2. Under 2.6.3 crashes of the same kind occured when trying to burn
DVDs. Under 2.6.4 this problem was fixed, but the new crash-on-read
problem described here showed up. 

I also have another problem with FireWire, which is probably unrelated -
this problem was also present in earlier 2.6 kernel releases:

Sometimes it happens that after I mount a DVD with data on it, I get
read errors. Unmounting and remounting the DVD solves this problem, it
can be read without problems after that. The error message on the
console is:

Buffer I/O error on device sr0, logical block 2204373
attempt to access beyond end of device
src: rw=0, want=8817500, limit=8640640
Buffer I/O error on device sr0, logical block 2204374

Please CC: me replies, since I'm not subscribed.

best regards,
Tillmann


