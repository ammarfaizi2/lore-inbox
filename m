Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVBVTgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVBVTgI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 14:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261427AbVBVTgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 14:36:07 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.141]:57572 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261409AbVBVTgC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 14:36:02 -0500
Subject: Re: [patch -mm series] ia64 specific /dev/mem handlers
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Matthew Wilcox <matthew@wil.cx>, jes@wildopensource.com,
       linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050222112513.4162860d.akpm@osdl.org>
References: <16923.193.128608.607599@jaguar.mkp.net>
	 <20050222020309.4289504c.akpm@osdl.org> <yq0ekf8lksf.fsf@jaguar.mkp.net>
	 <20050222175225.GK28741@parcelfarce.linux.theplanet.co.uk>
	 <20050222112513.4162860d.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 22 Feb 2005 11:35:38 -0800
Message-Id: <1109100938.25666.44.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was talking with Nigel Cunningham about doing something a little
different from the classic page flag bits when the number of users is
restricted and performance isn't ultra-critical.  Would something like
this work for you, instead of using a real page->flags bit for
PG_cached?

http://marc.theaimsgroup.com/?l=linux-kernel&m=110878103926956&w=2

BTW, they're planning on using two of those dynamic flags for software
suspend, and I'll probably use at least another two in the memory
hotplug code.  

-- Dave

