Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTIQQXq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 12:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262110AbTIQQXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 12:23:45 -0400
Received: from mail.broadpark.no ([217.13.4.2]:36748 "EHLO mail.broadpark.no")
	by vger.kernel.org with ESMTP id S262099AbTIQQXo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 12:23:44 -0400
Subject: Changes in siimage driver?
To: linux-kernel@vger.kernel.org
Message-ID: <oprvnjyf2oq1sf88@mail.broadpark.no>
From: Arve Knudsen <aknuds-1@broadpark.no>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Date: Wed, 17 Sep 2003 18:26:29 +0200
User-Agent: Opera7.20/Linux M2 build 463
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I've noticed that the siimage driver has changed since a few revisions 
back, I ran into some problems probably related to the driver when 
updating to 2.6.0-test5-mm1 however. First of all, I noticed hdparm 
reported really bad performance numbers for my Maxtor DiamondMax9 120GB. 
About 16MB/sec is reported for a buffered disk reads. The older version of 
the driver doesnt turn on DMA, but after enabling certain options (-d1, 
X66 etc.) with hdparm, I get ~50MB/S. It's not an ideal solution since now 
and then I get a bunch of "disabling irq #18" messages after running 
hdparm (I think, its part of the startup scripts), and I have to restart.

The second issue is more serious; after rebooting I noticed 3 files I had 
been working on, and a couple of directories I had downloaded were 
corrupted. The single files were filled with zeros, while the directories 
were impossible to access (I/O error). I couldn't even rm (-r) the 
directories. Am I the only one who's run into any sort of issues with the 
updated driver? From what I can see it hasn't been modified in the last 
revision (test5-bk4), hopefully noone is losing important data because of 
this (fortunately I had some recent backups). Anyway, I'd like some 
feedback on this from those in the know (the performance drop should be 
fairly easy to verify, unless hdparm is playing tricks on me).

Thanks in advance

Arve Knudsen
