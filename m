Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261996AbUCIP1c (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 10:27:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUCIP1c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 10:27:32 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:4615 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261996AbUCIP1a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 10:27:30 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 4/4] vm-mapped-x-active-lists
Date: Tue, 9 Mar 2004 16:26:39 +0100
User-Agent: KMail/1.6.1
Cc: Nick Piggin <piggin@cyberone.com.au>,
       Linux Memory Management <linux-mm@kvack.org>
References: <404D56D8.2000008@cyberone.com.au> <404D5784.9080004@cyberone.com.au>
In-Reply-To: <404D5784.9080004@cyberone.com.au>
X-Operating-System: Linux 2.4.20-wolk4.10s i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403091626.39479@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_vIeTAlxMIuV3BfO"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_vIeTAlxMIuV3BfO
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tuesday 09 March 2004 06:35, Nick Piggin wrote:

Hi Nick,

seems the following patch is required ontop of your patches?

ciao, Marc

--Boundary-00=_vIeTAlxMIuV3BfO
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="002_03-vm-mapped-x-active-lists-1-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="002_03-vm-mapped-x-active-lists-1-fix.patch"

--- old/arch/i386/mm/hugetlbpage.c	2004-03-09 14:57:42.000000000 +0100
+++ new/arch/i386/mm/hugetlbpage.c	2004-03-09 15:36:15.000000000 +0100
@@ -411,8 +411,8 @@ static void update_and_free_page(struct 
 	htlbzone_pages--;
 	for (j = 0; j < (HPAGE_SIZE / PAGE_SIZE); j++) {
 		map->flags &= ~(1 << PG_locked | 1 << PG_error | 1 << PG_referenced |
-				1 << PG_dirty | 1 << PG_active | 1 << PG_reserved |
-				1 << PG_private | 1<< PG_writeback);
+				1 << PG_dirty | 1 << PG_active_mapped | 1 << PG_active_unapped |
+				1 << PG_reserved | 1 << PG_private | 1<< PG_writeback);
 		set_page_count(map, 0);
 		map++;
 	}

--Boundary-00=_vIeTAlxMIuV3BfO--
