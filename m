Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261305AbVDDRuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261305AbVDDRuP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 13:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVDDRuP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 13:50:15 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:1230 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261305AbVDDRuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 13:50:10 -0400
Subject: [PATCH 0/4] create mm/Kconfig to detangle NUMA/DISCONTIG
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 10:50:04 -0700
Message-Id: <1112637004.27328.24.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The end goal of these particular patches is to allow us to get some
small bits of global mm/ code compiled for either NUMA or DISCONTIGMEM. 

Obviously, this alone doesn't justify messing with each architecture's
Kconfig file.  Think of the 4th patch as one example of how this new
file can be used.  We'll also be using it shortly for all of the page
migration and memory hotplug options.  It just starts to look silly when
you have a patch to add the exact same Kconfig option to four or five
different architectures.

Compile tested for 27 different .config configurations on 5 different
architectures.

-- Dave

