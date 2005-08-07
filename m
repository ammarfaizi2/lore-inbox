Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750816AbVHGDwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750816AbVHGDwh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 23:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750819AbVHGDwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 23:52:37 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:5812 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1750816AbVHGDwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 23:52:37 -0400
Subject: overcommit verses MAP_NORESERVE
From: Nicholas Miell <nmiell@comcast.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 06 Aug 2005 20:52:35 -0700
Message-Id: <1123386755.26540.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8.njm.2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does overcommit in mode 2 (OVERCOMMIT_NEVER) explicitly force
MAP_NORESERVE mappings to reserve memory?

My understanding is that MAP_NORESERVE is a way for apps to state that
they are aware that the memory allocated may not exist and that they
might get a SIGSEGV and that's OK with them.

Failing to do this makes certain well-know apps (*cough* Sun Java
*cough*) fail to run, which seems to be rather unhelpful.

-- 
Nicholas Miell <nmiell@comcast.net>

