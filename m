Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269438AbUJFWGk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269438AbUJFWGk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:06:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269409AbUJFU1g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 16:27:36 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:33453 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S269448AbUJFUUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 16:20:08 -0400
Message-Id: <200410062020.i96KKPN13520@raceme.attbi.com>
Subject: Driver access ito PCI card memory space question.
To: linux-kernel@vger.kernel.org
Date: Wed, 6 Oct 2004 15:20:25 -0500 (CDT)
From: kilian@bobodyne.com (Alan Kilian)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Folks,

     I'm not sure how to access the memory spaces on my PCI card.

     I do 


     From /var/log/messages:

		SSE: Start of card attachment.
		SSE: Found a DeCypher card, interrupting on line 3
		SSE: Bar0 From 0xfeaff000 to 0xfeafffff F=0x200 MEMORY space
		SSE: Bar1 From 0xfeafc000 to 0xfeafdfff F=0x200 MEMORY space
		SSE: Bar2 From 0xfe000000 to 0xfe7fffff F=0x200 MEMORY space

     My driver detects the card, and asks about the memory areas.

     Then I do request_mem_area(0xfeaff000,4095, "SSE");

     Then I do a readl(0xfeaff100); and get this:

        Unable to handle kernel paging request at virtual address feaff100

     Any hints? Maybe these are byte-addresses, and I need to do:
     readl(0xfeaff100>>2);

     I'm just beginning this adventure, so please excuse the basic 
     questions.

                           -Alan

-- 
- Alan Kilian <kilian(at)timelogic.com> 
Director of Bioinformatics, TimeLogic Corporation 763-449-7622
