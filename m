Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992789AbWJUKo4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992789AbWJUKo4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Oct 2006 06:44:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992829AbWJUKo4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Oct 2006 06:44:56 -0400
Received: from pm-mx5.mgn.net ([195.46.220.209]:42459 "EHLO pm-mx5.mgn.net")
	by vger.kernel.org with ESMTP id S2992789AbWJUKoz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Oct 2006 06:44:55 -0400
Date: Sat, 21 Oct 2006 12:44:54 +0200
From: Damien Wyart <damien.wyart@free.fr>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.19-rc2-mm2 : empty files on vfat file system
Message-ID: <20061021104454.GA1996@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have noticed something strange (and bad :) since using 2.6.19-rc2-mm2
(the problem is NOT present on 2.6.19-rc2-mm1 ; do not know for
mainline, I have not been able to test yet, but I think there have not
been recent changes in this area) : writing a file to a vfat
fs (fat 32) writes it, but with size 0 and no content. All this is
silent : no error message, nothing in the logs. After several attempts,
I checked the fs with fsck.vfat and it reported errors about some of the
files and told it was truncating them to size 0 (but their displayed
size was already 0, btw).


I hope this will ring a bell for some of you ? Maybe related to the
patch about strange bug messages about inodes in mm1 ?

-- 
Damien Wyart
