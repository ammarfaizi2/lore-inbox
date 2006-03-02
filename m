Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWCBWoX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWCBWoX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 17:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750985AbWCBWoX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 17:44:23 -0500
Received: from motgate4.mot.com ([144.189.100.102]:36587 "EHLO
	motgate4.mot.com") by vger.kernel.org with ESMTP id S1750975AbWCBWoW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 17:44:22 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: Memory overcommit and locked pages
Date: Thu, 2 Mar 2006 17:44:17 -0500
Message-ID: <2D25C6D9C1440E4E8228FC62AE286498C840D2@de01exm69.ds.mot.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Memory overcommit and locked pages
thread-index: AcY+StalYSYI0ji6SfCsF+2QWZIEnQ==
From: "Smarduch Mario-CMS063" <CMS063@motorola.com>
To: <linux-kernel@vger.kernel.org>
X-Brightmail-Tracker: AAAAAQAAAAQ=
X-White-List-Member: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking through the memory overcommit code, and noticed that page
cache size
and swap size are being taken for granted if system needs to reclaim
memory either
paging to disk or swap. But in reality if VMAs are locked that
assumption is broken,
(for anon and file backed pgs) success maybe returned even though memory
request 
can't be met. Is that a known fact?
 
- Mario
