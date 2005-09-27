Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964864AbVI0IhU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964864AbVI0IhU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 04:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbVI0IhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 04:37:19 -0400
Received: from lucidpixels.com ([66.45.37.187]:4736 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S964864AbVI0IhT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 04:37:19 -0400
Date: Tue, 27 Sep 2005 04:37:01 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
Subject: Repeatable crash under 2.6.13.2 + NFS
Message-ID: <Pine.LNX.4.63.0509270429360.1539@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simply copy some files *over NFS* from box1 to box2.
Or tar them, I did both.
The remote machine locks and freezes, no console output.
Copied 206MB before the MB/s went to 0 and crashed the remote box.
Nasty bug.  SCP works fine.
I've reported this before w/ .config etc but nobody responded.

It still occurs.

The nastiest part of all is, when the box that crashed is rebooting, it 
WILL NOT COME BACK up *IF* the machine that was sending the files to it is 
up.

It is almost like box1 (client) is sending some deadly packets to the 
other box and it cannot come up (it freezes after it initializes the NIC) 
until the other box is rebooted/shut down or disconnected from the 
network.



