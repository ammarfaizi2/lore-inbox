Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWBJOwB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWBJOwB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 09:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751265AbWBJOwB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 09:52:01 -0500
Received: from odin2.bull.net ([192.90.70.84]:40949 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S1751272AbWBJOwA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 09:52:00 -0500
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel@vger.kernel.org
Subject: Memory managment differences between 2.4 and 2.6 with mem=
Date: Fri, 10 Feb 2006 15:59:04 +0100
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Message-Id: <200602101559.04954.Serge.Noiraud@bull.net>
X-MIMETrack: Itemize by SMTP Server on MSGB-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 02/10/2006 03:51:56 PM,
	Serialize by Router on MSGB-002/FR/BULL(Release 5.0.11  |July 24, 2002) at
 02/10/2006 03:51:58 PM,
	Serialize complete at 02/10/2006 03:51:58 PM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
	In 2.4 I used to have mem=2000 on a machine with 2GB of memory.
I used the differences between 2000 and 2048 for a specific driver. 
This means I use addresses between 0x7d000000 and 0x7fffffff.
I was sure the system did not take this memory.

In 2.6 it does not work like that.
In /proc/iomem the end of memory is 0x7d000000.
I think this is normal.
but I saw the IDE driver allocate 1KB in addresses between 0x7d000000 and 0x7d0003ff

	I have some question  :
Is it normal ?
If it is not, how to get the same functionality ? are there some new options ?
Does memap= can help ?
Is there any impact in the driver ?

I red mel gorman "Understanding the Linux Virtual Memory Manager", but it does not help me.
In which chapter this is explained ?

-- 
Serge Noiraud
